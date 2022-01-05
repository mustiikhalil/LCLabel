//
//  LCLabelUITests.swift
//  LCLabelUITests
//
//  Created by Mustafa Khalil on 2022-01-05.
//

import XCTest

class LCLabelUITests: XCTestCase {

  private var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  func testLabel1() {
    app = XCUIApplication()
    app.launch()
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
    app.launch()
    let main = app.otherElements["main"]
    XCTAssertTrue(main.exists)
    XCTAssertTrue(main.staticTexts["translator"].exists)

    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 10, y: 400))
    XCTAssertEqual(main.staticTexts["translator"].label, "")
    app.tapCoordinate(at: CGPoint(x: 40, y: 430))
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
}

private extension XCUIApplication {
  func tapCoordinate(at point: CGPoint) {
    let normalized = coordinate(withNormalizedOffset: .zero)
    let offset = CGVector(dx: point.x, dy: point.y)
    let coordinate = normalized.withOffset(offset)
    print(coordinate)
    coordinate.tap()
  }
}
