import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: FleetStore
    @StateObject private var notifications = DealNotificationService.shared

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                Form {
                    notificationSection
                    filterSection
                    modelSection
                    sourceSection
                    scannerSection
                    aboutSection
                }
                .scrollContentBackground(.hidden)
                .tint(FleetTheme.saberBlue)
            }
            .navigationTitle("Settings")
            .toolbarBackground(FleetTheme.voidBlack.opacity(0.9), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task {
                await notifications.refreshStatus()
            }
        }
    }

    private var notificationSection: some View {
        Section {
            Toggle("Deal alerts", isOn: prefs(\.enabled))
            Toggle("Great deals only", isOn: prefs(\.greatDealsOnly))
            Toggle("Include good deals", isOn: prefs(\.includeGoodDeals))
            Toggle("Notify on new Great", isOn: prefs(\.notifyOnNewGreatDeal))
            Toggle("Quiet hours", isOn: prefs(\.quietHoursEnabled))

            if store.notificationPreferences.quietHoursEnabled {
                Stepper(
                    "Quiet start: \(store.notificationPreferences.quietHoursStart):00",
                    value: prefs(\.quietHoursStart),
                    in: 0...23
                )
                Stepper(
                    "Quiet end: \(store.notificationPreferences.quietHoursEnd):00",
                    value: prefs(\.quietHoursEnd),
                    in: 0...23
                )
            }

            Button("Enable system notifications") {
                Task { await notifications.requestAuthorization() }
            }
            .foregroundStyle(FleetTheme.saberGreen)

            LabeledContent("Permission") {
                Text(permissionLabel)
                    .foregroundStyle(FleetTheme.textSecondary)
            }
        } header: {
            Text("Notifications")
        } footer: {
            Text("Fleet Builder snipes Great (green) and Good (yellow) deals in real time as scanners refresh.")
        }
    }

    private var filterSection: some View {
        Section("Snipe Filters") {
            Toggle("HW4 / AI4 only", isOn: prefs(\.hw4Only))
            Toggle("FSD-capable hardware only", isOn: prefs(\.fsdCapableOnly))

            VStack(alignment: .leading) {
                Text("Max price: \(store.notificationPreferences.maxPrice, format: .currency(code: "USD").precision(.fractionLength(0)))")
                Slider(
                    value: Binding(
                        get: { store.notificationPreferences.maxPrice },
                        set: { store.notificationPreferences.maxPrice = $0 }
                    ),
                    in: 15_000...150_000,
                    step: 1_000
                )
            }

            VStack(alignment: .leading) {
                Text("Max miles: \(store.notificationPreferences.maxMileage.formatted())")
                Slider(
                    value: Binding(
                        get: { Double(store.notificationPreferences.maxMileage) },
                        set: { store.notificationPreferences.maxMileage = Int($0) }
                    ),
                    in: 5_000...200_000,
                    step: 1_000
                )
            }

            Stepper(
                "Min year: \(store.notificationPreferences.minYear)",
                value: prefs(\.minYear),
                in: 2018...2026
            )

            Stepper(
                "Max accidents: \(store.notificationPreferences.maxAccidentCount)",
                value: prefs(\.maxAccidentCount),
                in: 0...5
            )
        }
    }

    private var modelSection: some View {
        Section("Models") {
            ForEach(TeslaModel.allCases) { model in
                Toggle(model.rawValue, isOn: Binding(
                    get: { store.notificationPreferences.enabledModels.contains(model) },
                    set: { on in
                        if on {
                            store.notificationPreferences.enabledModels.insert(model)
                        } else {
                            store.notificationPreferences.enabledModels.remove(model)
                        }
                    }
                ))
            }
        }
    }

    private var sourceSection: some View {
        Section {
            ForEach(ListingSource.allCases) { source in
                Toggle(source.rawValue, isOn: Binding(
                    get: { store.notificationPreferences.enabledSources.contains(source) },
                    set: { on in
                        if on {
                            store.notificationPreferences.enabledSources.insert(source)
                        } else {
                            store.notificationPreferences.enabledSources.remove(source)
                        }
                    }
                ))
            }
        } header: {
            Text("Marketplaces")
        } footer: {
            Text("CarGurus, Cars.com, Autotrader, Facebook Marketplace, Craigslist, Tesla Used, Edmunds, TrueCar, Carfax, Bring a Trailer.")
        }
    }

    private var scannerSection: some View {
        Section("Scanner") {
            Stepper(
                "Poll every \(Int(store.notificationPreferences.pollIntervalSeconds))s",
                value: Binding(
                    get: { store.notificationPreferences.pollIntervalSeconds },
                    set: { store.notificationPreferences.pollIntervalSeconds = $0 }
                ),
                in: 30...600,
                step: 30
            )

            Picker("Feed sort", selection: $store.feedFilters.sort) {
                ForEach(FeedFilters.FeedSort.allCases) { sort in
                    Text(sort.rawValue).tag(sort)
                }
            }

            Button("Refresh scanners now") {
                Task { await store.refresh() }
            }
        }
    }

    private var aboutSection: some View {
        Section("About") {
            LabeledContent("App", value: "Fleet Builder")
            LabeledContent("Focus", value: "Tesla Y · 3 · S · X · Cybertruck")
            Text("Deal grades use price vs fair market, mileage vs age, repair/accident history, and HW4/FSD hardware bonuses — inspired by CarGurus-style deal ratings.")
                .font(.footnote)
                .foregroundStyle(FleetTheme.textSecondary)
        }
    }

    private var permissionLabel: String {
        switch notifications.authorizationStatus {
        case .authorized, .provisional: return "Authorized"
        case .denied: return "Denied"
        case .notDetermined: return "Not asked"
        case .ephemeral: return "Ephemeral"
        @unknown default: return "Unknown"
        }
    }

    private func prefs<T>(_ keyPath: WritableKeyPath<NotificationPreferences, T>) -> Binding<T> {
        Binding(
            get: { store.notificationPreferences[keyPath: keyPath] },
            set: { store.notificationPreferences[keyPath: keyPath] = $0 }
        )
    }
}
