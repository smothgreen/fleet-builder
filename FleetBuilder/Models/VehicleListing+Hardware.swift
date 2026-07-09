import Foundation

extension VehicleListing {
    func withHardware(version: HardwareVersion, fsdCapable: Bool) -> VehicleListing {
        VehicleListing(
            id: id,
            vin: vin,
            model: model,
            trim: trim,
            year: year,
            price: price,
            mileage: mileage,
            title: title,
            location: location,
            source: source,
            listingURL: listingURL,
            imageURL: imageURL,
            exteriorColor: exteriorColor,
            interiorColor: interiorColor,
            autopilot: autopilot,
            hardwareVersion: version,
            hasFSDCapableHardware: fsdCapable,
            accidentCount: accidentCount,
            ownerCount: ownerCount,
            repairHistory: repairHistory,
            listedAt: listedAt,
            dealerName: dealerName,
            dealScore: dealScore,
            dealGrade: dealGrade,
            scoreBreakdown: scoreBreakdown
        )
    }
}
