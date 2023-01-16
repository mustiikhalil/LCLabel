// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import LCLabel
import UIKit

final class AutoLayoutLCLabelViewController: UIViewController {

  var stackView: UIStackView!

  var currentPressedURL: URL?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.accessibilityIdentifier = "main"
    view.backgroundColor = .white

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

    // MARK: - Label
    let label = labelFactory(
      frame: .zero,
      text: text)
    label.delegate = self

    stackView = UIStackView(arrangedSubviews: [label])
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(
        equalTo: view.topAnchor,
        constant: 50),
      stackView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(
        equalTo: view.trailingAnchor),
      stackView.bottomAnchor.constraint(
        lessThanOrEqualTo: view.bottomAnchor,
        constant: -50),
    ])
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
    label.numberOfLines = 0
    label.attributedText = text
    return label
  }

}

extension AutoLayoutLCLabelViewController: LCLabelDelegate {

  func didPress(url: URL, at point: CGPoint) {
    currentPressedURL = url
  }

}
