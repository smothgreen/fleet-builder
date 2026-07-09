import SwiftUI

@main
struct FleetBuilderApp: App {
    @StateObject private var store = FleetStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
                .task {
                    await store.bootstrap()
                }
        }
    }
}

struct RootTabView: View {
    @EnvironmentObject private var store: FleetStore

    var body: some View {
        TabView {
            DealFeedView()
                .tabItem {
                    Label("Deals", systemImage: "scope")
                }

            SourcesView()
                .tabItem {
                    Label("Scanners", systemImage: "antenna.radiowaves.left.and.right")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        .tint(FleetTheme.saberGreen)
    }
}
