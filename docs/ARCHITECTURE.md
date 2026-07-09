# Fleet Builder Architecture

## Data flow

```
Marketplaces (CarGurus, FB, Tesla Used, …)
        │
        ▼
 ListingAggregator  ──►  VINHardwareDecoder
        │
        ▼
 DealScoringEngine  ──►  graded VehicleListing[]
        │
        ├──► FleetStore (feed + filters)
        └──► DealNotificationService (Great/Good snipes)
```

## Scoring weights

| Signal | Weight | Inputs |
|--------|--------|--------|
| Price | 45% | Asking vs fair market (MSRP × depreciation × miles × AP/HW/condition) |
| Mileage | 25% | Actual vs 12k mi/year expected |
| Condition | 20% | Accidents, repair severity, owners |
| Hardware | +0–8 pts | HW4/AI4 bonus |

## Live connectors

Provider types in `Services/Listings/ListingAggregator.swift` return `[]` until a backend endpoint is set. Use `RemoteListingProvider(endpoint:)` or fill each provider’s `fetchListings` with partner APIs. Respect each site’s Terms of Service — prefer official APIs over scraping.

## Models covered

Model Y → Model 3 → Model S → Model X → Cybertruck
