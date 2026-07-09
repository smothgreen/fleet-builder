import XCTest
@testable import FleetBuilder

final class DealScoringEngineTests: XCTestCase {
    private let engine = DealScoringEngine.shared

    func testGreatDealScoresHighForUnderMarketCleanY() {
        let listing = SampleCatalog.all.first { $0.id == "y-great-1" }!
        let scored = engine.score(listing)
        XCTAssertGreaterThanOrEqual(scored.dealScore, 68)
        XCTAssertTrue([DealGrade.great, .good].contains(scored.dealGrade))
        XCTAssertNotNil(scored.scoreBreakdown)
        XCTAssertLessThan(scored.scoreBreakdown!.marketDeltaPercent, 0)
    }

    func testDamagedOverpricedIsBad() {
        let listing = SampleCatalog.all.first { $0.id == "x-bad-1" }!
        let scored = engine.score(listing)
        XCTAssertEqual(scored.dealGrade, .bad)
        XCTAssertLessThan(scored.dealScore, 55)
    }

    func testHighMileagePenalizesScore() {
        let listing = SampleCatalog.all.first { $0.id == "y-bad-miles" }!
        let scored = engine.score(listing)
        XCTAssertLessThan(scored.scoreBreakdown!.mileageScore, 50)
    }

    func testHW4AddsHardwareBonus() {
        let listing = SampleCatalog.all.first { $0.id == "y-hw4-great" }!
        let scored = engine.score(listing)
        XCTAssertGreaterThanOrEqual(scored.scoreBreakdown!.hardwareBonus, 8)
    }

    func testAllSampleListingsProduceValidGrades() {
        for listing in engine.scoreAll(SampleCatalog.all) {
            XCTAssertGreaterThanOrEqual(listing.dealScore, 0)
            XCTAssertLessThanOrEqual(listing.dealScore, 100)
            XCTAssertTrue(DealGrade.allCases.contains(listing.dealGrade))
        }
    }

    func testNotificationPreferencesFiltersGreatOnly() {
        var prefs = NotificationPreferences.default
        prefs.greatDealsOnly = true
        prefs.includeGoodDeals = false
        prefs.notifyOnNewGreatDeal = true

        let scored = engine.scoreAll(SampleCatalog.all)
        let allowed = scored.filter { prefs.allows($0) }
        XCTAssertTrue(allowed.allSatisfy { $0.dealGrade == .great })
    }
}
