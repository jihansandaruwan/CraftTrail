import XCTest

final class CraftTrailUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-ui-testing"]
        app.launch()
    }

    func testOpenCraftAndSaveFavourite() {
        let card = app.descendants(matching: .any)["craft.mask"]
        XCTAssertTrue(card.waitForExistence(timeout: 8))
        card.tap()

        let save = app.buttons["favourite.toggle"]
        XCTAssertTrue(save.waitForExistence(timeout: 5))
        save.tap()

        let back = app.navigationBars.buttons["CraftTrail"]
        if back.waitForExistence(timeout: 2) {
            back.tap()
        }

        app.tabBars.buttons["Favourites"].tap()
        XCTAssertTrue(app.staticTexts["Ambalangoda Masks"].waitForExistence(timeout: 5))
    }
}
