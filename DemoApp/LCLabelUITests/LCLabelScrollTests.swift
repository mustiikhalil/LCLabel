// Copyright © 2022 Mustafa Khalil, Inc.
// Licensed under the Apache License, Version 2.0 (the 'License');
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
