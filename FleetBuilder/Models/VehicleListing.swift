import Foundation

enum DealGrade: String, CaseIterable, Codable, Hashable {
    case great = "Great"
    case good = "Good"
    case fair = "Fair"
    case bad = "Bad"

    var sortPriority: Int {
        switch self {
        case .great: return 0
        case .good: return 1
        case .fair: return 2
        case .bad: return 3
        }
    }

    /// Lightsaber vibe colors (hex-friendly names for Theme).
    var glowName: String {
        switch self {
        case .great: return "saberGreen"
        case .good: return "saberYellow"
        case .fair: return "saberAmber"
        case .bad: return "saberRed"
        }
    }

    var subtitle: String {
        switch self {
        case .great: return "Sniper-worthy deal"
        case .good: return "Solid fleet pickup"
        case .fair: return "Market average"
        case .bad: return "Walk away"
        }
    }
}

enum ListingSource: String, CaseIterable, Codable, Identifiable, Hashable {
    case carGurus = "CarGurus"
    case carsCom = "Cars.com"
    case autotrader = "Autotrader"
    case facebookMarketplace = "Facebook Marketplace"
    case craigslist = "Craigslist"
    case teslaUsed = "Tesla Used Inventory"
    case edmunds = "Edmunds"
    case trueCar = "TrueCar"
    case carfax = "Carfax"
    case bringATrailer = "Bring a Trailer"

    var id: String { rawValue }

    var baseSearchURL: String {
        switch self {
        case .carGurus:
            return "https://www.cargurus.com/Cars/l-Used-Tesla"
        case .carsCom:
            return "https://www.cars.com/shopping/results/?makes[]=tesla"
        case .autotrader:
            return "https://www.autotrader.com/cars-for-sale/tesla"
        case .facebookMarketplace:
            return "https://www.facebook.com/marketplace/search/?query=tesla"
        case .craigslist:
            return "https://www.craigslist.org/search/cta?query=tesla"
        case .teslaUsed:
            return "https://www.tesla.com/inventory/used"
        case .edmunds:
            return "https://www.edmunds.com/tesla/"
        case .trueCar:
            return "https://www.truecar.com/used-cars-for-sale/listings/tesla/"
        case .carfax:
            return "https://www.carfax.com/Used-Tesla_w113"
        case .bringATrailer:
            return "https://bringatrailer.com/tesla/"
        }
    }
}

struct RepairRecord: Codable, Hashable, Identifiable {
    var id: String { "\(date.timeIntervalSince1970)-\(description)" }
    let date: Date
    let description: String
    let costEstimate: Double?
    let severity: RepairSeverity

    enum RepairSeverity: String, Codable, Hashable {
        case minor
        case moderate
        case major
        case structural
    }
}

struct VehicleListing: Identifiable, Codable, Hashable {
    let id: String
    let vin: String?
    let model: TeslaModel
    let trim: String?
    let year: Int
    let price: Double
    let mileage: Int
    let title: String
    let location: String
    let source: ListingSource
    let listingURL: URL
    let imageURL: URL?
    let exteriorColor: String?
    let interiorColor: String?
    let autopilot: AutopilotCapability
    let hardwareVersion: HardwareVersion
    let hasFSDCapableHardware: Bool
    let accidentCount: Int
    let ownerCount: Int
    let repairHistory: [RepairRecord]
    let listedAt: Date
    let dealerName: String?

    /// Populated by DealScoringEngine.
    var dealScore: Double
    var dealGrade: DealGrade
    var scoreBreakdown: DealScoreBreakdown?

    var displayName: String {
        if let trim, !trim.isEmpty {
            return "Tesla \(model.rawValue) \(trim)"
        }
        return "Tesla \(model.rawValue)"
    }

    var mileageSubtitle: String {
        let miles = mileage.formatted(.number.notation(.compactName))
        return "\(miles) mi · \(year)"
    }
}

enum AutopilotCapability: String, Codable, Hashable {
    case none = "None"
    case autopilot = "Autopilot"
    case enhancedAutopilot = "Enhanced Autopilot"
    case fsd = "Full Self-Driving"
    case unknown = "Unknown"
}

enum HardwareVersion: String, Codable, Hashable, CaseIterable {
    case hw2 = "HW2"
    case hw2_5 = "HW2.5"
    case hw3 = "HW3"
    case hw4 = "HW4"
    case ai4 = "AI4"
    case unknown = "Unknown"

    var isFSDCapableModern: Bool {
        switch self {
        case .hw4, .ai4:
            return true
        case .hw3:
            return true // FSD capable but older cameras
        case .hw2, .hw2_5, .unknown:
            return false
        }
    }

    var badgeLabel: String {
        switch self {
        case .hw4, .ai4: return "HW4"
        case .hw3: return "HW3"
        case .hw2_5: return "HW2.5"
        case .hw2: return "HW2"
        case .unknown: return "?"
        }
    }
}

struct DealScoreBreakdown: Codable, Hashable {
    let priceScore: Double
    let mileageScore: Double
    let conditionScore: Double
    let hardwareBonus: Double
    let marketDeltaPercent: Double
    let fairMarketValue: Double
    let notes: [String]
}
