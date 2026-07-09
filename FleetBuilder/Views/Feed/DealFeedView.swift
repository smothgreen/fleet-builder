import SwiftUI

struct DealFeedView: View {
    @EnvironmentObject private var store: FleetStore
    @State private var pulse = false

    var body: some View {
        NavigationStack {
            ZStack {
                StarfieldBackground()

                VStack(spacing: 0) {
                    header
                    filterBar
                    feedList
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $store.selectedListing) { listing in
                DealDetailView(listing: listing)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("FLEET BUILDER")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [FleetTheme.holocronGold, FleetTheme.saberBlue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .lightsaberGlow(FleetTheme.holocronGold, intensity: 0.5)

                    Text("Tesla deal sniper")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(FleetTheme.textSecondary)
                }

                Spacer()

                Button {
                    Task { await store.refresh() }
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(FleetTheme.saberBlue)
                        .padding(12)
                        .background(FleetTheme.panel)
                        .clipShape(Circle())
                        .overlay(Circle().strokeBorder(FleetTheme.saberBlue.opacity(0.35), lineWidth: 1))
                        .rotationEffect(.degrees(store.isRefreshing ? 360 : 0))
                        .animation(
                            store.isRefreshing
                                ? .linear(duration: 0.8).repeatForever(autoreverses: false)
                                : .default,
                            value: store.isRefreshing
                        )
                }
            }

            HStack(spacing: 12) {
                StatusChip(
                    title: "\(store.greatDealCount) GREAT",
                    color: FleetTheme.saberGreen,
                    pulsing: pulse
                )
                StatusChip(
                    title: "\(store.visibleListings.count) LIVE",
                    color: FleetTheme.saberBlue
                )
                if let last = store.lastRefreshed {
                    Text("Updated \(last.formatted(.relative(presentation: .named)))")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundStyle(FleetTheme.textMuted)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                pulse = true
            }
        }
    }

    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(TeslaModel.allCases) { model in
                    let selected = store.feedFilters.models.contains(model)
                    FilterChip(title: model.rawValue, selected: selected, color: FleetTheme.saberBlue) {
                        if selected {
                            store.feedFilters.models.remove(model)
                        } else {
                            store.feedFilters.models.insert(model)
                        }
                    }
                }

                Divider().frame(height: 20).overlay(Color.white.opacity(0.2))

                ForEach([DealGrade.great, .good, .fair, .bad], id: \.self) { grade in
                    let selected = store.feedFilters.grades.contains(grade)
                    FilterChip(
                        title: grade.rawValue,
                        selected: selected,
                        color: FleetTheme.gradeColor(grade)
                    ) {
                        if selected {
                            store.feedFilters.grades.remove(grade)
                        } else {
                            store.feedFilters.grades.insert(grade)
                        }
                    }
                }

                FilterChip(
                    title: "HW4",
                    selected: store.feedFilters.hw4Only,
                    color: FleetTheme.saberBlue
                ) {
                    store.feedFilters.hw4Only.toggle()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
    }

    private var feedList: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                if store.visibleListings.isEmpty {
                    emptyState
                } else {
                    ForEach(store.visibleListings) { listing in
                        DealCardView(listing: listing) {
                            store.selectedListing = listing
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 100)
            .padding(.top, 4)
        }
        .refreshable {
            await store.refresh()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "scope")
                .font(.system(size: 40))
                .foregroundStyle(FleetTheme.saberBlue)
                .lightsaberGlow(FleetTheme.saberBlue)
            Text("No targets in range")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundStyle(FleetTheme.textPrimary)
            Text("Widen filters or refresh scanners")
                .font(.system(size: 14, design: .rounded))
                .foregroundStyle(FleetTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 80)
    }
}

struct StatusChip: View {
    let title: String
    let color: Color
    var pulsing: Bool = false

    var body: some View {
        Text(title)
            .font(.system(size: 11, weight: .heavy, design: .rounded))
            .tracking(0.6)
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(color.opacity(0.12))
            .overlay(
                Capsule().strokeBorder(color.opacity(pulsing ? 0.8 : 0.35), lineWidth: 1)
            )
            .clipShape(Capsule())
            .scaleEffect(pulsing ? 1.04 : 1.0)
            .lightsaberGlow(color, intensity: pulsing ? 0.8 : 0.3)
    }
}

struct FilterChip: View {
    let title: String
    let selected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundStyle(selected ? color : FleetTheme.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(selected ? color.opacity(0.15) : FleetTheme.panel.opacity(0.8))
                .overlay(
                    Capsule().strokeBorder(selected ? color.opacity(0.6) : FleetTheme.panelStroke, lineWidth: 1)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
