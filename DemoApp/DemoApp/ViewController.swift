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
import UIKit

final class LCLabelViewController: UIViewController {

  var count: Int = 0
  var label: LCLabel!
  var label2: LCLabel!
  var label3: LCLabel!
  var label4: LCLabel!
  var label5: UILabel!

  var currentPressedURL: URL?

  override func viewDidLoad() {
    super.viewDidLoad()
    view.accessibilityIdentifier = "main"
    view.backgroundColor = .white
    let width = view.frame.width - 30

    let text = NSMutableAttributedString(
      string: "welcome to this new adventure with a very very long text, this should break to a new line, this should have a very very very long text!",
      attributes: [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
      ])
    let range = (text.string as NSString).range(of: "welcome")
    text.addAttribute(.link, value: URL(string: "tel://909001")!, range: range)
    text.addAttribute(.foregroundColor, value: UIColor.red, range: range)
    text.addAttribute(.underlineStyle, value: 0, range: range)
    text.addAttribute(.underlineColor, value: UIColor.clear, range: range)

    var rect = CGRect(
      x: 10,
      y: 100,
      width: width,
      height: 90)

    // MARK: - Label
    label = labelFactory(
      frame: CGRect(origin: rect.origin, size: rect.size),
      text: text)
    label.textInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    label.delegate = self

    // MARK: - Label 2
    rect.origin.y += 100
    label2 = labelFactory(
      frame: CGRect(origin: rect.origin, size: rect.size),
      text: text)
    label2.delegate = self

    // MARK: - Label 3
    rect.origin.y += 100
    label3 = labelFactory(
      frame: CGRect(origin: rect.origin, size: rect.size),
      text: text)
    label3.numberOfLines = 0
    label3.textInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    label3.delegate = self

    // MARK: - Label 4
    rect.origin.y += 100
    let longTextRange = (text.string as NSString)
      .range(of: "very very long text")
    text.addAttribute(
      .link,
      value: URL(string: "https://github.com")!,
      range: longTextRange)
    text.addAttribute(
      .foregroundColor,
      value: UIColor.red,
      range: longTextRange)
    text.addAttribute(.underlineStyle, value: 0, range: longTextRange)
    text.addAttribute(
      .underlineColor,
      value: UIColor.clear,
      range: longTextRange)

    label4 = labelFactory(
      frame: CGRect(origin: rect.origin, size: rect.size),
      text: text)
    label4.numberOfLines = 0
    label4.textAlignment = .center
    label4.delegate = self

    rect.origin.y += 100
    label5 = UILabel()
    label5.isUserInteractionEnabled = true
    label5.accessibilityIdentifier = "translator"
    label5.frame = CGRect(origin: rect.origin, size: rect.size)
    view.addSubview(label5)
  }

  func labelFactory(
    frame: CGRect,
    text: NSAttributedString) -> LCLabel
  {
    let label = LCLabel(frame: .zero)
    label.frame = frame
    label.backgroundColor = .black
    view.addSubview(label)
    label.textAlignment = .top
    label.isUserInteractionEnabled = true
    label.numberOfLines = 1
    label.attributedText = text
    count += 1
    label.accessibilityIdentifier = "lcllabel+\(count)"
    return label
  }

}

extension LCLabelViewController: LCLabelDelegate {

  func didPress(url: URL, at point: CGPoint) {
    currentPressedURL = url
    label5.text = url.absoluteString
  }

}
