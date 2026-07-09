# Fleet Builder

**Tesla fleet deal sniper** — a standalone SwiftUI iOS app with a Star Wars / lightsaber UI that grades used Teslas (Model Y, 3, S, X, Cybertruck) and notifies you when a Great deal appears.

## Open in Xcode

```bash
open FleetBuilder/FleetBuilder.xcodeproj
```

Requirements: Xcode 15+, iOS 17+, Apple Developer team for device + push notifications.

## What you get

### Lightsaber deal feed
- Large scrollable deal cards with **green / yellow / red** glow borders (Great / Good / Bad)
- Circular car photo on the left
- Title like **Tesla Model Y Long Range**
- Subtext: miles · year
- Green (or grade-colored) status dot
- HW4 badge when FSD-capable modern hardware is detected

### Detail view
- Full score breakdown (price, mileage, condition)
- Fair-market estimate and % vs market
- Repair / accident history
- Hardware / FSD capability
- Deep link to the listing website

### Deal algorithm (CarGurus-inspired)
Scores each listing 0–100 from:
1. **Price** vs fair market (model MSRP, age depreciation, mileage, Autopilot/FSD, HW4)
2. **Mileage** vs expected for age
3. **Condition** — accidents, repair severity, owner count
4. **Hardware bonus** — HW4 / AI4 preferred for fleet FSD

| Grade | Color | Meaning |
|-------|-------|---------|
| Great | Green | Sniper-worthy under-market + clean |
| Good | Yellow | Solid fleet pickup |
| Fair | Amber | Market average |
| Bad | Red | Overpriced or damaged |

### HW4 / FSD VIN heuristics
`VINHardwareDecoder` combines VIN + model year windows:
- Cybertruck → HW4
- 2024+ → HW4-likely
- 2023 S/X refresh → HW4-likely
- 2019–2022 → HW3 (FSD-capable)
- Listing text can override when it mentions HW4

### Marketplaces / scanners
Provider stubs + deep-link catalog for:
CarGurus · Cars.com · Autotrader · Facebook Marketplace · Craigslist · Tesla Used Inventory · Edmunds · TrueCar · Carfax · Bring a Trailer

Live scraping/APIs need partner keys and a backend proxy (ToS). Until then, a rich **sample catalog** powers the UI and notifications so you can build and demo immediately.

### Notification settings
- Great-only vs include Good
- HW4 only / FSD-capable only
- Max price, max miles, min year, max accidents
- Per-model and per-marketplace toggles
- Quiet hours + poll interval (real-time sniping loop)

## Project layout

```
FleetBuilder/
├── FleetBuilder.xcodeproj
├── FleetBuilder/
│   ├── App/                 # Entry + tabs
│   ├── Models/              # Listings, grades, settings
│   ├── Services/
│   │   ├── DealScoring/     # Algorithm
│   │   ├── Listings/        # Aggregator + providers + sample data
│   │   ├── VIN/             # HW4 decoder
│   │   └── Notifications/   # Local deal alerts
│   ├── Theme/               # Star Wars / lightsaber styling
│   └── Views/               # Feed, detail, settings, scanners
└── FleetBuilderTests/
```

## Wire live inventory

1. Stand up a small backend that polls/search-APIs the marketplaces you have rights to use.
2. Point each `RemoteListingProvider` / provider `endpoint` at that JSON API (`[VehicleListing]`).
3. Keep `SampleCatalogProvider` for offline demos or remove it in production.

## Tests

In Xcode: **Product → Test** (⌘U), or:

```bash
xcodebuild test -scheme FleetBuilder -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Brand

Dark space background, holocron gold wordmark, lightsaber edge glows on deal cards — built for fast, intuitive fleet sniping.
