import SwiftUI

struct DealCardView: View {
    let listing: VehicleListing
    var onTap: () -> Void

    @State private var appeared = false

    private var gradeColor: Color { FleetTheme.gradeColor(listing.dealGrade) }

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                carThumb

                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text(listing.displayName)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundStyle(FleetTheme.textPrimary)
                            .lineLimit(1)

                        Spacer(minLength: 4)

                        gradeDot
                    }

                    Text(listing.mileageSubtitle)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(FleetTheme.textSecondary)

                    HStack(spacing: 10) {
                        Text(listing.price, format: .currency(code: "USD").precision(.fractionLength(0)))
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(gradeColor)

                        if listing.hasFSDCapableHardware {
                            HardwareBadge(version: listing.hardwareVersion)
                        }

                        Spacer()

                        Text(listing.source.rawValue)
                            .font(.system(size: 11, weight: .medium, design: .rounded))
                            .foregroundStyle(FleetTheme.textMuted)
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [gradeColor.opacity(0.7), gradeColor.opacity(0.15), .white.opacity(0.08)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 1.5
                    )
            )
            .lightsaberGlow(gradeColor, intensity: listing.dealGrade == .great ? 1.0 : 0.55)
        }
        .buttonStyle(.plain)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 18)
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.82)) {
                appeared = true
            }
        }
    }

    private var carThumb: some View {
        ZStack {
            Circle()
                .fill(FleetTheme.panel)
                .frame(width: 72, height: 72)
                .overlay(
                    Circle()
                        .strokeBorder(gradeColor.opacity(0.65), lineWidth: 2.5)
                )
                .lightsaberGlow(gradeColor, intensity: 0.7)

            AsyncImage(url: listing.imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholderIcon
                case .empty:
                    ProgressView()
                        .tint(gradeColor)
                @unknown default:
                    placeholderIcon
                }
            }
            .frame(width: 64, height: 64)
            .clipShape(Circle())
        }
    }

    private var placeholderIcon: some View {
        Image(systemName: "car.fill")
            .font(.system(size: 24))
            .foregroundStyle(FleetTheme.textMuted)
    }

    private var gradeDot: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(gradeColor)
                .frame(width: 10, height: 10)
                .lightsaberGlow(gradeColor, intensity: 1.2)

            Text(listing.dealGrade.rawValue.uppercased())
                .font(.system(size: 10, weight: .heavy, design: .rounded))
                .tracking(0.8)
                .foregroundStyle(gradeColor)
        }
    }

    private var cardBackground: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(FleetTheme.panel.opacity(0.92))

            // Lightsaber edge wash from left
            LinearGradient(
                colors: [gradeColor.opacity(0.18), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
    }
}

struct HardwareBadge: View {
    let version: HardwareVersion

    var body: some View {
        Text(version.badgeLabel)
            .font(.system(size: 10, weight: .bold, design: .rounded))
            .padding(.horizontal, 7)
            .padding(.vertical, 3)
            .foregroundStyle(FleetTheme.saberBlue)
            .background(FleetTheme.saberBlue.opacity(0.15))
            .overlay(
                Capsule().strokeBorder(FleetTheme.saberBlue.opacity(0.45), lineWidth: 1)
            )
            .clipShape(Capsule())
            .lightsaberGlow(FleetTheme.saberBlue, intensity: 0.4)
    }
}
