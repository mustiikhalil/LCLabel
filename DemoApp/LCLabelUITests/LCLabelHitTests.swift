// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import XCTest

// Screenshots taken on an iPhone 13
final class LCLabelHitTests: XCTestCase {

  private var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testLabel1() {
    app = XCUIApplication()
    app.launchArguments = [""]
    app.launch()

    XCTAssertEqual(
      app.staticTexts.matching(.staticText, identifier: "lcllabel+1").firstMatch
        .identifier,
      "lcllabel+1")

    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)

    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 10, y: 100))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 20, y: 110))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 200, y: 110))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 30, y: 110))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 60, y: 105))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
  }

  func testLabel2() {
    app = XCUIApplication()
    app.launchArguments = [""]
    app.launch()
    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)
    app.tapCoordinate(at: CGPoint(x: 100, y: 205))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 10, y: 200))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
  }

  func testLabel3() {
    app = XCUIApplication()
    app.launchArguments = [""]
    app.launch()
    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)

    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 10, y: 300))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 30, y: 310))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 110, y: 300 + 45))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 50, y: 300 + 45))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
  }

  func testLabel4() {
    app = XCUIApplication()
    app.launchArguments = [""]
    app.launch()
    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)

    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 10, y: 400))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 30, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
    app.tapCoordinate(at: CGPoint(x: 200, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
    app.tapCoordinate(at: CGPoint(x: 30, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
    app.tapCoordinate(at: CGPoint(x: 60, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
    app.tapCoordinate(at: CGPoint(x: 20, y: 450))
    XCTAssertEqual(main.staticTexts["translator"].label, "https://github.com")
    app.tapCoordinate(at: CGPoint(x: 60, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "tel://909001")
    app.tapCoordinate(at: CGPoint(x: 300, y: 430))
    XCTAssertEqual(main.staticTexts["translator"].label, "https://github.com")
  }

  func testScrollingThrough() {
    app = XCUIApplication()
    app.launchArguments = [""]
    app.launch()
    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)

    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.scrollCoordinate(
      at: CGPoint(x: 10, y: 400),
      to: CGPoint(x: 40, y: 430))
    XCTAssertEqual(
      main.staticTexts["translator"].label,
      "")
    app.scrollCoordinate(
      at: CGPoint(x: 30, y: 400),
      to: CGPoint(x: 10, y: 430))
    XCTAssertEqual(
      main.staticTexts["translator"].label,
      "")
  }
}

private extension XCUIApplication {
  func tapCoordinate(at point: CGPoint) {
    let normalized = coordinate(withNormalizedOffset: .zero)
    let offset = CGVector(dx: point.x, dy: point.y)
    let coordinate = normalized.withOffset(offset)
    coordinate.tap()
  }

  func scrollCoordinate(
    at point: CGPoint,
    to toPoint: CGPoint)
  {
    let normalized = coordinate(withNormalizedOffset: .zero)
    let offset = CGVector(dx: point.x, dy: point.y)
    let coordinate = normalized.withOffset(offset)
    let newOffset = CGVector(dx: toPoint.x, dy: toPoint.y)
    let newCoordinate = normalized.withOffset(newOffset)
    coordinate.press(
      forDuration: 0.5,
      thenDragTo: newCoordinate)
  }
}
