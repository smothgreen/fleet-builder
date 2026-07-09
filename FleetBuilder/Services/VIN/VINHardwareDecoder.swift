import Foundation

/// Infers Tesla Autopilot hardware from VIN + model year heuristics.
///
/// Tesla VINs (North America):
/// Positions matter for plant/model; HW is not encoded as a single digit,
/// so we combine known production windows with optional listing metadata.
///
/// HW4 / AI4 rollout (approximate):
/// - Model S / X refresh: ~Apr 2023+
/// - Model 3 Highland: late 2023+
/// - Model Y Juniper / late 2023+ builds increasingly HW4
/// - Cybertruck: HW4 / AI4 from launch
///
/// This is a best-effort classifier for fleet sniping — always verify on the listing.
struct VINHardwareDecoder {
    static let shared = VINHardwareDecoder()

    struct DecodeResult: Hashable {
        let hardware: HardwareVersion
        let fsdCapable: Bool
        let confidence: Double
        let notes: [String]
    }

    func decode(
        vin: String?,
        model: TeslaModel,
        year: Int,
        listingMentionsHW4: Bool = false,
        listingMentionsFSD: Bool = false
    ) -> DecodeResult {
        var notes: [String] = []

        if listingMentionsHW4 {
            notes.append("Listing text indicates HW4")
            return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.85, notes: notes)
        }

        if let vin, vin.count == 17 {
            let plant = plantCode(vin)
            let modelYearCode = yearCode(vin)
            notes.append("VIN plant=\(plant) yearCode=\(modelYearCode)")

            // Cybertruck always modern compute
            if model == .cybertruck {
                notes.append("Cybertruck ships with HW4/AI4")
                return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.95, notes: notes)
            }

            // Fremont (F) / Austin (A) / Berlin (B) / Shanghai (C) heuristics by year
            if year >= 2024 {
                notes.append("\(year)+ production strongly correlates with HW4")
                return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.8, notes: notes)
            }

            if year == 2023 {
                switch model {
                case .modelS, .modelX:
                    notes.append("2023 S/X refresh typically HW4")
                    return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.75, notes: notes)
                case .model3:
                    // Highland late 2023
                    notes.append("2023 Model 3 may be HW3 or Highland HW4 — verify")
                    return DecodeResult(hardware: .hw3, fsdCapable: true, confidence: 0.45, notes: notes)
                case .modelY:
                    notes.append("2023 Model Y often still HW3; late builds may be HW4")
                    return DecodeResult(hardware: .hw3, fsdCapable: true, confidence: 0.5, notes: notes)
                case .cybertruck:
                    return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.95, notes: notes)
                }
            }

            if year >= 2019 && year <= 2022 {
                notes.append("\(year) era typically HW3")
                return DecodeResult(hardware: .hw3, fsdCapable: true, confidence: 0.7, notes: notes)
            }

            if year >= 2016 && year <= 2018 {
                notes.append("\(year) era typically HW2/HW2.5")
                return DecodeResult(hardware: .hw2_5, fsdCapable: false, confidence: 0.65, notes: notes)
            }
        } else {
            notes.append("No VIN — using year/model heuristics only")
        }

        // Year-only fallback
        if model == .cybertruck || year >= 2024 {
            return DecodeResult(hardware: .hw4, fsdCapable: true, confidence: 0.6, notes: notes)
        }
        if year >= 2019 {
            let fsd = listingMentionsFSD || year >= 2019
            return DecodeResult(hardware: .hw3, fsdCapable: fsd, confidence: 0.55, notes: notes)
        }
        return DecodeResult(hardware: .unknown, fsdCapable: false, confidence: 0.3, notes: notes)
    }

    /// Position 11 plant code
    private func plantCode(_ vin: String) -> Character {
        let chars = Array(vin.uppercased())
        guard chars.count == 17 else { return "?" }
        return chars[10]
    }

    /// Position 10 model year code
    private func yearCode(_ vin: String) -> Character {
        let chars = Array(vin.uppercased())
        guard chars.count == 17 else { return "?" }
        return chars[9]
    }

    /// Known VIN prefixes / patterns for documentation & future enrichment.
    static let documentedHW4Windows: [String] = [
        "Cybertruck: all VINs (2023+)",
        "Model S Plaid / refreshed S: ~VIN year 2023+ with HW4 cameras",
        "Model X refreshed: ~2023+",
        "Model 3 Highland: late 2023+",
        "Model Y: phased HW4 through 2023–2024; 2024+ treat as HW4-likely",
    ]
}
