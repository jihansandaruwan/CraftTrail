import SwiftData
import XCTest
@testable import CraftTrail

final class CatalogTests: XCTestCase {
    func testBlankSearchReturnsEveryCraft() {
        let result = CatalogSearch.crafts(in: SampleCatalog.crafts, query: CatalogQuery(text: "   "))
        XCTAssertEqual(result.count, SampleCatalog.crafts.count)
    }

    func testSearchFindsMaskIgnoringCase() {
        let result = CatalogSearch.crafts(
            in: SampleCatalog.crafts,
            query: CatalogQuery(text: "MASK")
        )
        XCTAssertEqual(result.map(\.id), ["mask"])
    }

    func testCategoryFilterKeepsOnlyLace() {
        let result = CatalogSearch.crafts(
            in: SampleCatalog.crafts,
            query: CatalogQuery(category: .lace)
        )
        XCTAssertEqual(result.map(\.id), ["beeralu"])
    }

    func testHillCountryHasFourCrafts() {
        let result = CatalogSearch.crafts(
            in: SampleCatalog.crafts,
            query: CatalogQuery(region: .hillCountry)
        )
        XCTAssertEqual(result.count, 4)
    }

    func testUnknownSearchIsEmpty() {
        let crafts = CatalogSearch.crafts(
            in: SampleCatalog.crafts,
            query: CatalogQuery(text: "zzzz-not-a-craft")
        )
        let places = CatalogSearch.destinations(
            in: SampleCatalog.destinations,
            crafts: SampleCatalog.crafts,
            query: CatalogQuery(text: "zzzz-not-a-craft")
        )
        XCTAssertTrue(crafts.isEmpty)
        XCTAssertTrue(places.isEmpty)
    }

    func testGalleSearchFindsLaceStop() {
        let places = CatalogSearch.destinations(
            in: SampleCatalog.destinations,
            crafts: SampleCatalog.crafts,
            query: CatalogQuery(text: "galle")
        )
        XCTAssertEqual(places.map(\.id), ["galle"])
    }

    func testCatalogLinksAndLabels() {
        let craftIDs = Set(SampleCatalog.crafts.map(\.id))
        XCTAssertEqual(craftIDs.count, SampleCatalog.crafts.count)

        for place in SampleCatalog.destinations {
            XCTAssertTrue(place.isIllustrative, "\(place.name) must stay marked as a demo stop")
            XCTAssertTrue(craftIDs.contains(place.craftID))
            XCTAssertTrue((5.5...10.0).contains(place.latitude))
            XCTAssertTrue((79.0...82.5).contains(place.longitude))
        }
    }
}

@MainActor
final class FavouriteStoreTests: XCTestCase {
    func testToggleSavesAndRemoves() throws {
        let container = try ModelContainer(
            for: FavouriteRecord.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let store = FavouriteStore()
        store.attach(container.mainContext)

        store.toggle(id: "mask", kind: FavouriteKind.craft, title: "Ambalangoda Masks")
        XCTAssertTrue(store.contains("mask"))
        XCTAssertEqual(store.records.first?.title, "Ambalangoda Masks")

        let reloaded = FavouriteStore()
        reloaded.attach(container.mainContext)
        XCTAssertTrue(reloaded.contains("mask"))

        reloaded.toggle(id: "mask", kind: FavouriteKind.craft, title: "Ambalangoda Masks")
        XCTAssertFalse(reloaded.contains("mask"))
        XCTAssertTrue(reloaded.records.isEmpty)
    }
}
