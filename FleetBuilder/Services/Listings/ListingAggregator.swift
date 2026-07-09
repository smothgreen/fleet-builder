import Foundation

protocol ListingProvider: Sendable {
    var source: ListingSource { get }
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing]
}

/// Aggregates all dealer / marketplace sources for fleet deal sniping.
actor ListingAggregator {
    static let shared = ListingAggregator()

    private let providers: [any ListingProvider]
    private let scorer = DealScoringEngine.shared
    private let decoder = VINHardwareDecoder.shared

    init(providers: [any ListingProvider]? = nil) {
        self.providers = providers ?? [
            CarGurusProvider(),
            CarsDotComProvider(),
            AutotraderProvider(),
            FacebookMarketplaceProvider(),
            CraigslistProvider(),
            TeslaUsedInventoryProvider(),
            EdmundsProvider(),
            TrueCarProvider(),
            SampleCatalogProvider(), // always seeds demo + fills gaps
        ]
    }

    func refresh(models: [TeslaModel] = TeslaModel.allCases) async -> [VehicleListing] {
        var combined: [VehicleListing] = []

        await withTaskGroup(of: [VehicleListing].self) { group in
            for provider in providers {
                group.addTask {
                    do {
                        return try await provider.fetchListings(models: models)
                    } catch {
                        return []
                    }
                }
            }
            for await batch in group {
                combined.append(contentsOf: batch)
            }
        }

        // Enrich hardware from VIN, then score
        let enriched = combined.map { listing -> VehicleListing in
            let result = decoder.decode(
                vin: listing.vin,
                model: listing.model,
                year: listing.year,
                listingMentionsHW4: listing.hardwareVersion == .hw4,
                listingMentionsFSD: listing.autopilot == .fsd
            )
            if listing.hardwareVersion == .unknown {
                return listing.withHardware(version: result.hardware, fsdCapable: result.fsdCapable)
            }
            return listing
        }

        // Dedupe by VIN or id
        var seen = Set<String>()
        let deduped = enriched.filter { listing in
            let key = listing.vin ?? listing.id
            if seen.contains(key) { return false }
            seen.insert(key)
            return true
        }

        return scorer.scoreAll(deduped)
    }
}

// MARK: - Provider stubs
// Live scrapers / APIs require partner keys & ToS compliance.
// Each provider returns structured search URLs + optional live fetch hooks.
// SampleCatalogProvider supplies rich demo inventory for the UI.

struct ProviderSearchBlueprint: Hashable {
    let source: ListingSource
    let model: TeslaModel
    let url: URL
}

enum ListingProviderCatalog {
    static func allSearchURLs(for models: [TeslaModel] = TeslaModel.allCases) -> [ProviderSearchBlueprint] {
        var out: [ProviderSearchBlueprint] = []
        for source in ListingSource.allCases {
            for model in models {
                let q = model.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? model.rawValue
                let urlString: String
                switch source {
                case .carGurus:
                    urlString = "https://www.cargurus.com/Cars/l-Used-Tesla-\(q.replacingOccurrences(of: " ", with: "-"))"
                case .carsCom:
                    urlString = "https://www.cars.com/shopping/results/?makes[]=tesla&models[]=tesla-\(model.shortName.lowercased())"
                case .autotrader:
                    urlString = "https://www.autotrader.com/cars-for-sale/tesla/\(q.replacingOccurrences(of: " ", with: "-").lowercased())"
                case .facebookMarketplace:
                    urlString = "https://www.facebook.com/marketplace/search/?query=Tesla%20\(q)"
                case .craigslist:
                    urlString = "https://www.craigslist.org/search/cta?query=Tesla+\(q.replacingOccurrences(of: " ", with: "+"))"
                case .teslaUsed:
                    urlString = "https://www.tesla.com/inventory/used/\(modelInventoryPath(model))"
                case .edmunds:
                    urlString = "https://www.edmunds.com/tesla/\(model.rawValue.lowercased().replacingOccurrences(of: " ", with: "-"))/"
                case .trueCar:
                    urlString = "https://www.truecar.com/used-cars-for-sale/listings/tesla/\(model.rawValue.lowercased().replacingOccurrences(of: " ", with: "-"))/"
                case .carfax:
                    urlString = "https://www.carfax.com/Used-Tesla-\(q.replacingOccurrences(of: " ", with: "-"))_w113"
                case .bringATrailer:
                    urlString = "https://bringatrailer.com/tesla/?s=\(q)"
                }
                if let url = URL(string: urlString) {
                    out.append(ProviderSearchBlueprint(source: source, model: model, url: url))
                }
            }
        }
        return out
    }

    private static func modelInventoryPath(_ model: TeslaModel) -> String {
        switch model {
        case .modelY: return "my"
        case .model3: return "m3"
        case .modelS: return "ms"
        case .modelX: return "mx"
        case .cybertruck: return "ct"
        }
    }
}

struct RemoteListingProvider: ListingProvider {
    let source: ListingSource
    /// When API keys are configured, hit a backend proxy. Until then, empty.
    var endpoint: URL?

    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] {
        guard let endpoint else { return [] }
        let (data, _) = try await URLSession.shared.data(from: endpoint)
        return try JSONDecoder().decode([VehicleListing].self, from: data)
    }
}

struct CarGurusProvider: ListingProvider {
    let source: ListingSource = .carGurus
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct CarsDotComProvider: ListingProvider {
    let source: ListingSource = .carsCom
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct AutotraderProvider: ListingProvider {
    let source: ListingSource = .autotrader
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct FacebookMarketplaceProvider: ListingProvider {
    let source: ListingSource = .facebookMarketplace
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct CraigslistProvider: ListingProvider {
    let source: ListingSource = .craigslist
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct TeslaUsedInventoryProvider: ListingProvider {
    let source: ListingSource = .teslaUsed
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct EdmundsProvider: ListingProvider {
    let source: ListingSource = .edmunds
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}

struct TrueCarProvider: ListingProvider {
    let source: ListingSource = .trueCar
    func fetchListings(models: [TeslaModel]) async throws -> [VehicleListing] { [] }
}
