import SwiftUI

enum FleetTheme {
    static let voidBlack = Color(red: 0.02, green: 0.03, blue: 0.06)
    static let deepSpace = Color(red: 0.04, green: 0.06, blue: 0.12)
    static let panel = Color(red: 0.07, green: 0.09, blue: 0.16)
    static let panelStroke = Color.white.opacity(0.12)

    static let saberGreen = Color(red: 0.20, green: 0.95, blue: 0.45)
    static let saberYellow = Color(red: 0.98, green: 0.86, blue: 0.22)
    static let saberAmber = Color(red: 0.95, green: 0.62, blue: 0.18)
    static let saberRed = Color(red: 0.95, green: 0.22, blue: 0.28)
    static let saberBlue = Color(red: 0.35, green: 0.72, blue: 1.0)
    static let holocronGold = Color(red: 0.86, green: 0.72, blue: 0.38)

    static let textPrimary = Color.white.opacity(0.95)
    static let textSecondary = Color.white.opacity(0.62)
    static let textMuted = Color.white.opacity(0.4)

    static func gradeColor(_ grade: DealGrade) -> Color {
        switch grade {
        case .great: return saberGreen
        case .good: return saberYellow
        case .fair: return saberAmber
        case .bad: return saberRed
        }
    }

    static func gradeGlow(_ grade: DealGrade) -> Color {
        gradeColor(grade).opacity(0.55)
    }
}

struct StarfieldBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    FleetTheme.voidBlack,
                    FleetTheme.deepSpace,
                    Color(red: 0.05, green: 0.08, blue: 0.14),
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Soft nebula washes
            Circle()
                .fill(FleetTheme.saberBlue.opacity(0.08))
                .frame(width: 320, height: 320)
                .blur(radius: 80)
                .offset(x: -120, y: -220)

            Circle()
                .fill(FleetTheme.saberGreen.opacity(0.06))
                .frame(width: 280, height: 280)
                .blur(radius: 70)
                .offset(x: 140, y: 180)

            GeometryReader { geo in
                Canvas { context, size in
                    for i in 0..<60 {
                        let x = CGFloat((i * 97) % Int(size.width))
                        let y = CGFloat((i * 53) % Int(size.height))
                        let r = CGFloat((i % 3) + 1) * 0.6
                        let rect = CGRect(x: x, y: y, width: r, height: r)
                        context.fill(Path(ellipseIn: rect), with: .color(.white.opacity(0.35)))
                    }
                }
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
        }
    }
}

struct LightsaberGlow: ViewModifier {
    let color: Color
    var intensity: Double = 1.0

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.35 * intensity), radius: 4, x: 0, y: 0)
            .shadow(color: color.opacity(0.55 * intensity), radius: 12, x: 0, y: 0)
            .shadow(color: color.opacity(0.25 * intensity), radius: 24, x: 0, y: 0)
    }
}

extension View {
    func lightsaberGlow(_ color: Color, intensity: Double = 1.0) -> some View {
        modifier(LightsaberGlow(color: color, intensity: intensity))
    }
}
