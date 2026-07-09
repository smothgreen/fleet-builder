import Foundation

/// CarGurus-inspired deal algorithm for Tesla fleet sniping.
///
/// Scores listings on:
/// 1. Price vs fair market value (model/year/mileage adjusted)
/// 2. Mileage vs expected for age
/// 3. Condition (accidents, repairs, owners)
/// 4. Hardware bonus (HW4 / FSD-capable)
///
/// Grades map to lightsaber colors:
/// - Great (green): exceptional under-market + clean condition
/// - Good (yellow): solid value
/// - Fair (amber): market average
/// - Bad (red): overpriced or damaged
struct DealScoringEngine {
    static let shared = DealScoringEngine()

    func score(_ listing: VehicleListing) -> VehicleListing {
        let fmv = fairMarketValue(for: listing)
        let marketDelta = ((listing.price - fmv) / fmv) * 100.0

        let priceScore = scorePrice(deltaPercent: marketDelta)
        let mileageScore = scoreMileage(listing)
        let conditionScore = scoreCondition(listing)
        let hardwareBonus = scoreHardware(listing)

        // Weighted composite 0–100
        var total = (priceScore * 0.45)
            + (mileageScore * 0.25)
            + (conditionScore * 0.20)
            + hardwareBonus

        total = min(100, max(0, total))

        let grade = grade(for: total, marketDelta: marketDelta, conditionScore: conditionScore)

        var notes: [String] = []
        if marketDelta <= -12 {
            notes.append("Priced \(abs(Int(marketDelta)))% under fair market")
        } else if marketDelta >= 8 {
            notes.append("Priced \(Int(marketDelta))% over fair market")
        }
        if listing.mileage < expectedMiles(for: listing) * 0.7 {
            notes.append("Low miles for age")
        }
        if listing.accidentCount == 0 && listing.repairHistory.isEmpty {
            notes.append("Clean history")
        }
        if listing.hasFSDCapableHardware {
            notes.append("\(listing.hardwareVersion.badgeLabel) FSD-capable")
        }
        if listing.accidentCount > 0 {
            notes.append("\(listing.accidentCount) reported accident(s)")
        }

        var scored = listing
        scored.dealScore = total
        scored.dealGrade = grade
        scored.scoreBreakdown = DealScoreBreakdown(
            priceScore: priceScore,
            mileageScore: mileageScore,
            conditionScore: conditionScore,
            hardwareBonus: hardwareBonus,
            marketDeltaPercent: marketDelta,
            fairMarketValue: fmv,
            notes: notes
        )
        return scored
    }

    func scoreAll(_ listings: [VehicleListing]) -> [VehicleListing] {
        listings.map(score)
    }

    // MARK: - Fair Market Value

    func fairMarketValue(for listing: VehicleListing) -> Double {
        let age = max(0, Double(Calendar.current.component(.year, from: Date()) - listing.year))
        var value = listing.model.msrpBaseline

        // Depreciation: ~18% year 1, then ~12% compounding
        if age >= 1 {
            value *= 0.82
            if age > 1 {
                value *= pow(0.88, age - 1)
            }
        }

        // Mileage adjustment vs expected
        let expected = expectedMiles(for: listing)
        let mileDelta = Double(listing.mileage) - expected
        // ~$0.12 per mile over/under expected
        value -= mileDelta * 0.12

        // Trim / Autopilot premiums
        switch listing.autopilot {
        case .fsd:
            value += 6_000
        case .enhancedAutopilot:
            value += 3_000
        case .autopilot, .none, .unknown:
            break
        }

        if listing.hardwareVersion == .hw4 || listing.hardwareVersion == .ai4 {
            value += 2_500
        }

        // Condition drag
        value -= Double(listing.accidentCount) * 2_500
        for repair in listing.repairHistory {
            switch repair.severity {
            case .minor: value -= 400
            case .moderate: value -= 1_200
            case .major: value -= 3_500
            case .structural: value -= 8_000
            }
        }

        if listing.ownerCount > 2 {
            value -= Double(listing.ownerCount - 2) * 800
        }

        return max(8_000, value)
    }

    func expectedMiles(for listing: VehicleListing) -> Double {
        let age = max(0.5, Double(Calendar.current.component(.year, from: Date()) - listing.year))
        return age * listing.model.expectedAnnualMiles
    }

    // MARK: - Component scores

    private func scorePrice(deltaPercent: Double) -> Double {
        // -20% → 100, 0% → 55, +15% → 10
        if deltaPercent <= -20 { return 100 }
        if deltaPercent >= 20 { return 5 }
        // Linear-ish map
        return max(5, min(100, 55 - (deltaPercent * 2.25)))
    }

    private func scoreMileage(_ listing: VehicleListing) -> Double {
        let expected = expectedMiles(for: listing)
        guard expected > 0 else { return 50 }
        let ratio = Double(listing.mileage) / expected
        // 0.5x expected → 100, 1.0 → 70, 1.5 → 35, 2.0 → 10
        if ratio <= 0.5 { return 100 }
        if ratio >= 2.0 { return 10 }
        return max(10, 100 - ((ratio - 0.5) * 60))
    }

    private func scoreCondition(_ listing: VehicleListing) -> Double {
        var score = 100.0
        score -= Double(listing.accidentCount) * 22
        for repair in listing.repairHistory {
            switch repair.severity {
            case .minor: score -= 5
            case .moderate: score -= 12
            case .major: score -= 25
            case .structural: score -= 45
            }
        }
        if listing.ownerCount >= 3 { score -= 10 }
        if listing.ownerCount >= 4 { score -= 10 }
        return max(0, min(100, score))
    }

    private func scoreHardware(_ listing: VehicleListing) -> Double {
        switch listing.hardwareVersion {
        case .hw4, .ai4:
            return 8
        case .hw3:
            return 3
        case .hw2_5, .hw2, .unknown:
            return 0
        }
    }

    private func grade(for total: Double, marketDelta: Double, conditionScore: Double) -> DealGrade {
        // Hard gates: structural damage or severe overpay can't be Great
        if conditionScore < 40 { return .bad }
        if marketDelta > 12 && total < 60 { return .bad }

        switch total {
        case 82...:
            return marketDelta <= -5 ? .great : .good
        case 68..<82:
            return .good
        case 48..<68:
            return .fair
        default:
            return .bad
        }
    }
}
