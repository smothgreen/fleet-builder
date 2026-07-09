import Foundation

struct NotificationPreferences: Codable, Equatable {
    var enabled: Bool = true
    var greatDealsOnly: Bool = false
    var includeGoodDeals: Bool = true
    var hw4Only: Bool = false
    var fsdCapableOnly: Bool = false
    var maxPrice: Double = 80_000
    var maxMileage: Int = 80_000
    var minYear: Int = 2020
    var enabledModels: Set<TeslaModel> = Set(TeslaModel.allCases)
    var enabledSources: Set<ListingSource> = Set(ListingSource.allCases)
    var maxAccidentCount: Int = 1
    var notifyOnNewGreatDeal: Bool = true
    var quietHoursEnabled: Bool = false
    var quietHoursStart: Int = 22 // 24h
    var quietHoursEnd: Int = 7
    var pollIntervalSeconds: TimeInterval = 120

    static let `default` = NotificationPreferences()

    enum CodingKeys: String, CodingKey {
        case enabled, greatDealsOnly, includeGoodDeals, hw4Only, fsdCapableOnly
        case maxPrice, maxMileage, minYear, enabledModels, enabledSources
        case maxAccidentCount, notifyOnNewGreatDeal, quietHoursEnabled
        case quietHoursStart, quietHoursEnd, pollIntervalSeconds
    }

    init() {}

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        enabled = try c.decodeIfPresent(Bool.self, forKey: .enabled) ?? true
        greatDealsOnly = try c.decodeIfPresent(Bool.self, forKey: .greatDealsOnly) ?? false
        includeGoodDeals = try c.decodeIfPresent(Bool.self, forKey: .includeGoodDeals) ?? true
        hw4Only = try c.decodeIfPresent(Bool.self, forKey: .hw4Only) ?? false
        fsdCapableOnly = try c.decodeIfPresent(Bool.self, forKey: .fsdCapableOnly) ?? false
        maxPrice = try c.decodeIfPresent(Double.self, forKey: .maxPrice) ?? 80_000
        maxMileage = try c.decodeIfPresent(Int.self, forKey: .maxMileage) ?? 80_000
        minYear = try c.decodeIfPresent(Int.self, forKey: .minYear) ?? 2020
        enabledModels = Set(try c.decodeIfPresent([TeslaModel].self, forKey: .enabledModels) ?? TeslaModel.allCases)
        enabledSources = Set(try c.decodeIfPresent([ListingSource].self, forKey: .enabledSources) ?? ListingSource.allCases)
        maxAccidentCount = try c.decodeIfPresent(Int.self, forKey: .maxAccidentCount) ?? 1
        notifyOnNewGreatDeal = try c.decodeIfPresent(Bool.self, forKey: .notifyOnNewGreatDeal) ?? true
        quietHoursEnabled = try c.decodeIfPresent(Bool.self, forKey: .quietHoursEnabled) ?? false
        quietHoursStart = try c.decodeIfPresent(Int.self, forKey: .quietHoursStart) ?? 22
        quietHoursEnd = try c.decodeIfPresent(Int.self, forKey: .quietHoursEnd) ?? 7
        pollIntervalSeconds = try c.decodeIfPresent(TimeInterval.self, forKey: .pollIntervalSeconds) ?? 120
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(enabled, forKey: .enabled)
        try c.encode(greatDealsOnly, forKey: .greatDealsOnly)
        try c.encode(includeGoodDeals, forKey: .includeGoodDeals)
        try c.encode(hw4Only, forKey: .hw4Only)
        try c.encode(fsdCapableOnly, forKey: .fsdCapableOnly)
        try c.encode(maxPrice, forKey: .maxPrice)
        try c.encode(maxMileage, forKey: .maxMileage)
        try c.encode(minYear, forKey: .minYear)
        try c.encode(Array(enabledModels), forKey: .enabledModels)
        try c.encode(Array(enabledSources), forKey: .enabledSources)
        try c.encode(maxAccidentCount, forKey: .maxAccidentCount)
        try c.encode(notifyOnNewGreatDeal, forKey: .notifyOnNewGreatDeal)
        try c.encode(quietHoursEnabled, forKey: .quietHoursEnabled)
        try c.encode(quietHoursStart, forKey: .quietHoursStart)
        try c.encode(quietHoursEnd, forKey: .quietHoursEnd)
        try c.encode(pollIntervalSeconds, forKey: .pollIntervalSeconds)
    }

    func allows(_ listing: VehicleListing) -> Bool {
        guard enabled else { return false }
        guard enabledModels.contains(listing.model) else { return false }
        guard enabledSources.contains(listing.source) else { return false }
        guard listing.price <= maxPrice else { return false }
        guard listing.mileage <= maxMileage else { return false }
        guard listing.year >= minYear else { return false }
        guard listing.accidentCount <= maxAccidentCount else { return false }

        if hw4Only {
            guard listing.hardwareVersion == .hw4 || listing.hardwareVersion == .ai4 else { return false }
        }
        if fsdCapableOnly {
            guard listing.hasFSDCapableHardware else { return false }
        }

        switch listing.dealGrade {
        case .great:
            return notifyOnNewGreatDeal || includeGoodDeals || !greatDealsOnly
        case .good:
            return includeGoodDeals && !greatDealsOnly
        case .fair, .bad:
            return false
        }
    }
}

struct FeedFilters: Equatable {
    var models: Set<TeslaModel> = Set(TeslaModel.allCases)
    var grades: Set<DealGrade> = [.great, .good, .fair]
    var hw4Only: Bool = false
    var maxPrice: Double = 120_000
    var maxMileage: Int = 150_000
    var sort: FeedSort = .bestDeal

    enum FeedSort: String, CaseIterable, Identifiable {
        case bestDeal = "Best Deal"
        case newest = "Newest"
        case priceLow = "Price ↑"
        case mileageLow = "Miles ↑"

        var id: String { rawValue }
    }

    func matches(_ listing: VehicleListing) -> Bool {
        guard models.contains(listing.model) else { return false }
        guard grades.contains(listing.dealGrade) else { return false }
        guard listing.price <= maxPrice else { return false }
        guard listing.mileage <= maxMileage else { return false }
        if hw4Only {
            guard listing.hardwareVersion == .hw4 || listing.hardwareVersion == .ai4 else { return false }
        }
        return true
    }

    func sorted(_ listings: [VehicleListing]) -> [VehicleListing] {
        let filtered = listings.filter(matches)
        switch sort {
        case .bestDeal:
            return filtered.sorted {
                if $0.dealGrade.sortPriority != $1.dealGrade.sortPriority {
                    return $0.dealGrade.sortPriority < $1.dealGrade.sortPriority
                }
                return $0.dealScore > $1.dealScore
            }
        case .newest:
            return filtered.sorted { $0.listedAt > $1.listedAt }
        case .priceLow:
            return filtered.sorted { $0.price < $1.price }
        case .mileageLow:
            return filtered.sorted { $0.mileage < $1.mileage }
        }
    }
}
