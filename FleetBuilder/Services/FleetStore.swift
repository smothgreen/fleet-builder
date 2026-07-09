import Foundation
import Combine

@MainActor
final class FleetStore: ObservableObject {
    @Published var listings: [VehicleListing] = []
    @Published var isRefreshing = false
    @Published var lastRefreshed: Date?
    @Published var feedFilters = FeedFilters()
    @Published var notificationPreferences: NotificationPreferences {
        didSet { persistPreferences() }
    }
    @Published var selectedListing: VehicleListing?
    @Published var errorMessage: String?

    private let aggregator = ListingAggregator.shared
    private let notifications = DealNotificationService.shared
    private var pollTask: Task<Void, Never>?
    private let prefsKey = "fleet.notificationPreferences"

    var visibleListings: [VehicleListing] {
        feedFilters.sorted(listings)
    }

    var greatDealCount: Int {
        listings.filter { $0.dealGrade == .great }.count
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: prefsKey),
           let decoded = try? JSONDecoder().decode(NotificationPreferences.self, from: data) {
            notificationPreferences = decoded
        } else {
            notificationPreferences = .default
        }
    }

    func bootstrap() async {
        await notifications.refreshStatus()
        await refresh()
        startPolling()
    }

    func refresh() async {
        isRefreshing = true
        errorMessage = nil
        defer { isRefreshing = false }

        let models = Array(notificationPreferences.enabledModels)
        let scored = await aggregator.refresh(models: models.isEmpty ? TeslaModel.allCases : models)
        listings = scored
        lastRefreshed = Date()
        await notifications.evaluateNewDeals(scored, preferences: notificationPreferences)
    }

    func startPolling() {
        pollTask?.cancel()
        let interval = max(30, notificationPreferences.pollIntervalSeconds)
        pollTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
                guard !Task.isCancelled else { break }
                await self?.refresh()
            }
        }
    }

    func stopPolling() {
        pollTask?.cancel()
        pollTask = nil
    }

    private func persistPreferences() {
        if let data = try? JSONEncoder().encode(notificationPreferences) {
            UserDefaults.standard.set(data, forKey: prefsKey)
        }
        startPolling()
    }
}
