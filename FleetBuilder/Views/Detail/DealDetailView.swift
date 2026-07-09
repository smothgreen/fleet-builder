import SwiftUI

struct DealDetailView: View {
    let listing: VehicleListing
    @Environment(\.openURL) private var openURL
    @State private var glowPulse = false

    private var gradeColor: Color { FleetTheme.gradeColor(listing.dealGrade) }

    var body: some View {
        ZStack {
            StarfieldBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    hero
                    gradeBanner
                    specsGrid
                    scoreSection
                    conditionSection
                    hardwareSection
                    openListingButton
                }
                .padding(20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(listing.model.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(FleetTheme.voidBlack.opacity(0.9), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
        }
    }

    private var hero: some View {
        HStack(spacing: 18) {
            ZStack {
                Circle()
                    .strokeBorder(gradeColor.opacity(glowPulse ? 0.95 : 0.45), lineWidth: 3)
                    .frame(width: 110, height: 110)
                    .lightsaberGlow(gradeColor, intensity: glowPulse ? 1.2 : 0.6)

                AsyncImage(url: listing.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        Image(systemName: "car.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(FleetTheme.textMuted)
                    }
                }
                .frame(width: 98, height: 98)
                .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(listing.displayName)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(FleetTheme.textPrimary)

                Text(listing.mileageSubtitle)
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(FleetTheme.textSecondary)

                Text(listing.price, format: .currency(code: "USD").precision(.fractionLength(0)))
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(gradeColor)
                    .lightsaberGlow(gradeColor, intensity: 0.5)

                Text("\(listing.location) · \(listing.source.rawValue)")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundStyle(FleetTheme.textMuted)
            }
        }
    }

    private var gradeBanner: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(listing.dealGrade.rawValue.uppercased())
                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                    .tracking(1.2)
                    .foregroundStyle(gradeColor)
                Text(listing.dealGrade.subtitle)
                    .font(.system(size: 13, design: .rounded))
                    .foregroundStyle(FleetTheme.textSecondary)
            }
            Spacer()
            Text("\(Int(listing.dealScore))")
                .font(.system(size: 36, weight: .black, design: .rounded))
                .foregroundStyle(gradeColor)
                .lightsaberGlow(gradeColor)
            Text("/100")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(FleetTheme.textMuted)
                .padding(.top, 12)
        }
        .padding(16)
        .background(gradeColor.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(gradeColor.opacity(0.45), lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var specsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            SpecCell(label: "Year", value: "\(listing.year)")
            SpecCell(label: "Miles", value: listing.mileage.formatted())
            SpecCell(label: "Color", value: listing.exteriorColor ?? "—")
            SpecCell(label: "Owners", value: "\(listing.ownerCount)")
            SpecCell(label: "Accidents", value: "\(listing.accidentCount)")
            SpecCell(label: "Autopilot", value: listing.autopilot.rawValue)
            if let vin = listing.vin {
                SpecCell(label: "VIN", value: String(vin.suffix(8)))
            }
            if let dealer = listing.dealerName {
                SpecCell(label: "Seller", value: dealer)
            }
        }
    }

    @ViewBuilder
    private var scoreSection: some View {
        if let breakdown = listing.scoreBreakdown {
            VStack(alignment: .leading, spacing: 12) {
                sectionTitle("Deal Intelligence")

                ScoreBar(label: "Price", value: breakdown.priceScore, color: FleetTheme.saberGreen)
                ScoreBar(label: "Mileage", value: breakdown.mileageScore, color: FleetTheme.saberYellow)
                ScoreBar(label: "Condition", value: breakdown.conditionScore, color: FleetTheme.saberBlue)

                HStack {
                    Text("Fair market")
                        .foregroundStyle(FleetTheme.textSecondary)
                    Spacer()
                    Text(breakdown.fairMarketValue, format: .currency(code: "USD").precision(.fractionLength(0)))
                        .foregroundStyle(FleetTheme.textPrimary)
                }
                .font(.system(size: 13, weight: .medium, design: .rounded))

                HStack {
                    Text("vs market")
                        .foregroundStyle(FleetTheme.textSecondary)
                    Spacer()
                    Text("\(breakdown.marketDeltaPercent, format: .number.precision(.fractionLength(1)))%")
                        .foregroundStyle(breakdown.marketDeltaPercent < 0 ? FleetTheme.saberGreen : FleetTheme.saberRed)
                }
                .font(.system(size: 13, weight: .medium, design: .rounded))

                ForEach(breakdown.notes, id: \.self) { note in
                    HStack(alignment: .top, spacing: 8) {
                        Circle().fill(gradeColor).frame(width: 6, height: 6).padding(.top, 5)
                        Text(note)
                            .font(.system(size: 13, design: .rounded))
                            .foregroundStyle(FleetTheme.textSecondary)
                    }
                }
            }
            .padding(16)
            .background(FleetTheme.panel.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(FleetTheme.panelStroke, lineWidth: 1)
            )
        }
    }

    private var conditionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("Condition & Repairs")
            if listing.repairHistory.isEmpty && listing.accidentCount == 0 {
                Text("Clean history — no reported accidents or major repairs.")
                    .font(.system(size: 14, design: .rounded))
                    .foregroundStyle(FleetTheme.saberGreen)
            } else {
                ForEach(listing.repairHistory) { repair in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(repair.description)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundStyle(FleetTheme.textPrimary)
                        Text("\(repair.severity.rawValue.capitalized) · \(repair.date.formatted(date: .abbreviated, time: .omitted))")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundStyle(FleetTheme.textMuted)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FleetTheme.panel.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var hardwareSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle("Autonomy Hardware")
            HStack {
                HardwareBadge(version: listing.hardwareVersion)
                Text(listing.hasFSDCapableHardware ? "FSD-capable compute" : "Not modern FSD hardware")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(listing.hasFSDCapableHardware ? FleetTheme.saberBlue : FleetTheme.saberRed)
            }
            Text("HW4 / AI4 vehicles have the newer camera suite and compute preferred for fleet FSD.")
                .font(.system(size: 12, design: .rounded))
                .foregroundStyle(FleetTheme.textMuted)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(FleetTheme.panel.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var openListingButton: some View {
        Button {
            openURL(listing.listingURL)
        } label: {
            HStack {
                Image(systemName: "safari.fill")
                Text("Open on \(listing.source.rawValue)")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "arrow.up.right")
            }
            .font(.system(size: 16, design: .rounded))
            .foregroundStyle(FleetTheme.voidBlack)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    colors: [gradeColor, gradeColor.opacity(0.75)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .lightsaberGlow(gradeColor, intensity: 0.8)
        }
        .buttonStyle(.plain)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 11, weight: .heavy, design: .rounded))
            .tracking(1.1)
            .foregroundStyle(FleetTheme.holocronGold)
    }
}

struct SpecCell: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.system(size: 10, weight: .bold, design: .rounded))
                .tracking(0.8)
                .foregroundStyle(FleetTheme.textMuted)
            Text(value)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(FleetTheme.textPrimary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(FleetTheme.panel.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct ScoreBar: View {
    let label: String
    let value: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(FleetTheme.textSecondary)
                Spacer()
                Text("\(Int(value))")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.08))
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * CGFloat(min(1, value / 100)))
                        .lightsaberGlow(color, intensity: 0.5)
                }
            }
            .frame(height: 6)
        }
    }
}
