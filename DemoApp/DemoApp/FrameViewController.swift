// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

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
    text.addAttribute(
      .lclabelLink,
      value: URL(string: "tel://909001")!,
      range: range)

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
      .lclabelLink,
      value: "https://github.com",
      range: longTextRange)

    label4 = labelFactory(
      frame: CGRect(origin: rect.origin, size: rect.size),
      text: text)
    label4.numberOfLines = 0
    label4.centeringTextAlignment = .center
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
    label.linkAttributes = [
      .foregroundColor: UIColor.white,
    ]
    label.centeringTextAlignment = .top
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
