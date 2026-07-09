import SwiftUI

struct SourcesView: View {
    private let blueprints = ListingProviderCatalog.allSearchURLs()

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                List {
                    Section {
                        Text("Live API connectors plug into a backend proxy. Until keys are configured, scanners use the sample catalog plus deep links into each marketplace.")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundStyle(FleetTheme.textSecondary)
                            .listRowBackground(FleetTheme.panel.opacity(0.5))
                    }

                    ForEach(ListingSource.allCases) { source in
                        Section(source.rawValue) {
                            ForEach(blueprints.filter { $0.source == source }, id: \.model) { bp in
                                Link(destination: bp.url) {
                                    HStack {
                                        Text(bp.model.rawValue)
                                            .foregroundStyle(FleetTheme.textPrimary)
                                        Spacer()
                                        Image(systemName: "arrow.up.right")
                                            .foregroundStyle(FleetTheme.saberBlue)
                                    }
                                }
                                .listRowBackground(FleetTheme.panel.opacity(0.7))
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Scanners")
            .toolbarBackground(FleetTheme.voidBlack.opacity(0.9), for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
