import Foundation

enum TeslaModel: String, CaseIterable, Identifiable, Codable, Hashable {
    case modelY = "Model Y"
    case model3 = "Model 3"
    case modelS = "Model S"
    case modelX = "Model X"
    case cybertruck = "Cybertruck"

    var id: String { rawValue }

    var shortName: String {
        switch self {
        case .modelY: return "Y"
        case .model3: return "3"
        case .modelS: return "S"
        case .modelX: return "X"
        case .cybertruck: return "CT"
        }
    }

    var searchKeywords: [String] {
        switch self {
        case .modelY: return ["Tesla Model Y", "Model Y"]
        case .model3: return ["Tesla Model 3", "Model 3"]
        case .modelS: return ["Tesla Model S", "Model S"]
        case .modelX: return ["Tesla Model X", "Model X"]
        case .cybertruck: return ["Tesla Cybertruck", "Cybertruck"]
        }
    }

    /// Approximate MSRP baselines used for deal scoring (USD).
    var msrpBaseline: Double {
        switch self {
        case .modelY: return 44_990
        case .model3: return 42_490
        case .modelS: return 74_990
        case .modelX: return 79_990
        case .cybertruck: return 79_990
        }
    }

    /// Expected annual mileage for depreciation curve.
    var expectedAnnualMiles: Double {
        switch self {
        case .cybertruck: return 12_000
        default: return 12_000
        }
    }
}
