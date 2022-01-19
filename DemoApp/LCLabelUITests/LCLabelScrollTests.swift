// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import LCLabel
import XCTest

final class LCLabelScrollTests: XCTestCase {

  private var app: XCUIApplication!

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  // Tested on an iPhone XS
  func testScrollingPerformace() {
    app = XCUIApplication()
    app.launchArguments = ["-scrollview", "-cellnumbers"]
    app.launch()

    let measureOptions = XCTMeasureOptions()
    measureOptions.invocationOptions = [.manuallyStop]
    measure(
      metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric],
      options: measureOptions)
    {
      app.swipeUp(velocity: .default)
      stopMeasuring()
      app.swipeDown()
    }
  }

  // Tested on an iPhone XS
  func testScrollingPerformaceFast() {
    app = XCUIApplication()
    app.launchArguments = ["-scrollview", "-cellnumbers"]
    app.launch()

    let measureOptions = XCTMeasureOptions()
    measureOptions.invocationOptions = [.manuallyStop]
    measure(
      metrics: [XCTOSSignpostMetric.scrollingAndDecelerationMetric],
      options: measureOptions)
    {
      app.swipeUp(velocity: .fast)
      stopMeasuring()
      app.swipeDown()
    }
  }


}
