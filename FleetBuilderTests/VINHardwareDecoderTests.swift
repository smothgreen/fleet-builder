import XCTest
@testable import FleetBuilder

final class VINHardwareDecoderTests: XCTestCase {
    private let decoder = VINHardwareDecoder.shared

    func testCybertruckIsHW4() {
        let result = decoder.decode(
            vin: "7G2CEHED5RA112233",
            model: .cybertruck,
            year: 2024
        )
        XCTAssertEqual(result.hardware, .hw4)
        XCTAssertTrue(result.fsdCapable)
        XCTAssertGreaterThan(result.confidence, 0.8)
    }

    func test2024ModelYLikelyHW4() {
        let result = decoder.decode(
            vin: "7SAYGDEE1RA654321",
            model: .modelY,
            year: 2024
        )
        XCTAssertEqual(result.hardware, .hw4)
        XCTAssertTrue(result.fsdCapable)
    }

    func test2021Model3IsHW3() {
        let result = decoder.decode(
            vin: "5YJ3E1EA5MF123456",
            model: .model3,
            year: 2021
        )
        XCTAssertEqual(result.hardware, .hw3)
        XCTAssertTrue(result.fsdCapable)
    }

    func testListingMentionOverrides() {
        let result = decoder.decode(
            vin: nil,
            model: .modelY,
            year: 2022,
            listingMentionsHW4: true
        )
        XCTAssertEqual(result.hardware, .hw4)
        XCTAssertTrue(result.fsdCapable)
    }

    func testProviderCatalogCoversAllSourcesAndModels() {
        let urls = ListingProviderCatalog.allSearchURLs()
        XCTAssertEqual(urls.count, ListingSource.allCases.count * TeslaModel.allCases.count)
        XCTAssertTrue(urls.allSatisfy { $0.url.scheme == "https" })
    }
}
