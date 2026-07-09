import Foundation
import UserNotifications

@MainActor
final class DealNotificationService: ObservableObject {
    static let shared = DealNotificationService()

    @Published private(set) var authorizationStatus: UNAuthorizationStatus = .notDetermined
    private var notifiedIDs = Set<String>()

    func requestAuthorization() async {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])
            if granted {
                authorizationStatus = .authorized
            } else {
                authorizationStatus = .denied
            }
        } catch {
            authorizationStatus = .denied
        }
    }

    func refreshStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        authorizationStatus = settings.authorizationStatus
    }

    func evaluateNewDeals(
        _ listings: [VehicleListing],
        preferences: NotificationPreferences
    ) async {
        guard preferences.enabled else { return }
        if preferences.quietHoursEnabled && isQuietHours(preferences) { return }

        await refreshStatus()
        guard authorizationStatus == .authorized || authorizationStatus == .provisional else { return }

        let candidates = listings.filter { preferences.allows($0) && !notifiedIDs.contains($0.id) }
        for listing in candidates.prefix(5) {
            await post(listing)
            notifiedIDs.insert(listing.id)
        }
    }

    private func post(_ listing: VehicleListing) async {
        let content = UNMutableNotificationContent()
        content.title = "\(listing.dealGrade.rawValue) Deal · \(listing.displayName)"
        content.subtitle = listing.mileageSubtitle
        content.body = "$\(Int(listing.price).formatted()) · \(listing.location) · \(listing.source.rawValue)"
        content.sound = .default
        content.userInfo = ["listingId": listing.id, "url": listing.listingURL.absoluteString]

        let request = UNNotificationRequest(
            identifier: "deal-\(listing.id)",
            content: content,
            trigger: nil
        )
        try? await UNUserNotificationCenter.current().add(request)
    }

    private func isQuietHours(_ prefs: NotificationPreferences) -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        let start = prefs.quietHoursStart
        let end = prefs.quietHoursEnd
        if start < end {
            return hour >= start && hour < end
        }
        // wraps midnight
        return hour >= start || hour < end
    }

    func resetNotifiedCache() {
        notifiedIDs.removeAll()
    }
}
