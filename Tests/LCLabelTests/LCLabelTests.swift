// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import LCLabel
import SnapshotTesting
import XCTest

// Screenshots taken on an iPhone 13
final class LCLabelTests: XCTestCase {

  // MARK: Internal

  func testTextCenterAlignment() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testCenterTextAlignment() {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center

    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
        .paragraphStyle: paragraph,
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testTextTopAlignment() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    label.centeringTextAlignment = .top
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testTextBottomAlignment() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    label.centeringTextAlignment = .bottom
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testLongText() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label with long text that is supposed to trunculate",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingTail
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testLongTextWithDifferentLineBreakMode() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label with long text that is supposed to trunculate",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    label.lineBreakMode = .byTruncatingMiddle
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }


  func testTextPadding() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel is a low cost label that can be padded",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 1
    label.textInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testInstagramLabelMimic() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\nOpen Source",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 8),
      ]))
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 2
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testLineFragmentPadding() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\nOpen Source",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 8),
      ]))
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.lineFragmentPadding = 10
    label.numberOfLines = 0
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testTwitterLabelMimic() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
      ]))
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 2
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testLinkEnsure() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: URL(string: "lclabel://welcome")!,
      ]))
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    label.numberOfLines = 2
    label.linkStyleValidation = .ensure
    let text = label.attributedText
    let range = NSRange(location: 0, length: attStr.length)
    text?.enumerateAttribute(.link, in: range, using: { value, range, _ in
      XCTAssertNil(value, "Should never return anything here!")
    })
  }

  func testLinkEnsureWithLinkAttributes() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: URL(string: "lclabel://welcome")!,
      ]))
    let label = LCLabel(frame: .zero)
    label.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.linkStyleValidation = .ensure
    label.attributedText = attStr
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    let text = label.attributedText
    let range = (text!.string as NSString).range(of: "@LCLabel")
    text?.enumerateAttributes(in: range, using: { attr, range, _ in
      XCTAssertEqual(
        (attr[.font] as? UIFont)?.pointSize, 12.0)
    })
  }

  func testSettingAttributesFirst() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: URL(string: "lclabel://welcome")!,
      ]))
    let label = LCLabel(frame: .zero)
    label.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.linkStyleValidation = .ensure
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.attributedText = attStr
    let text = label.attributedText
    let range = (text!.string as NSString).range(of: "@LCLabel")
    text?.enumerateAttributes(in: range, using: { attr, range, _ in
      XCTAssertEqual(
        (attr[.font] as? UIFont)?.pointSize, 12.0)
      XCTAssertEqual(
        (attr[.lclabelLink] as? URL)?.absoluteString, "lclabel://welcome")
    })
  }

  func testString() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: "lclabel://welcome",
      ]))
    let label = LCLabel(frame: .zero)
    label.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.linkStyleValidation = .ensure
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.backgroundColor = .black
    label.attributedText = attStr
    label.shouldExcludeUnderlinesFromText = true
    let text = label.attributedText
    let range = (text!.string as NSString).range(of: "@LCLabel")
    text?.enumerateAttributes(in: range, using: { attr, range, _ in
      XCTAssertEqual(
        attr[.lclabelLink] as? String, "lclabel://welcome")
    })
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testStringWithoutValidations() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: "lclabel://welcome",
      ]))
    let label = LCLabel(frame: .zero)
    label.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.shouldExcludeUnderlinesFromText = false
    label.linkStyleValidation = .skip
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.backgroundColor = .black
    label.attributedText = attStr
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }


  func testSuperLongText() {
    let text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet bibendum enim facilisis gravida neque. Orci a scelerisque purus semper eget duis at. Viverra justo nec ultrices dui sapien eget mi proin. Etiam non quam lacus suspendisse faucibus. Vel fringilla est ullamcorper eget nulla facilisi etiam. Donec enim diam vulputate ut pharetra sit amet aliquam id. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Ultrices gravida dictum fusce ut. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Turpis egestas sed tempus urna et pharetra. Pellentesque nec nam aliquam sem et tortor consequat. Risus sed vulputate odio ut enim blandit volutpat maecenas. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Blandit massa enim nec dui nunc mattis enim ut. Tristique sollicitudin nibh sit amet.
    """
    let attr: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.white,
      .font: UIFont.systemFont(ofSize: 14),
    ]
    let attStr = NSMutableAttributedString(
      string: text,
      attributes: attr)

    let width: CGFloat = 300
    let size = (attStr.string as NSString).boundingRect(
      with: CGSize(width: width, height: .greatestFiniteMagnitude),
      options: [.usesLineFragmentOrigin, .usesFontLeading],
      attributes: attr,
      context: nil)
    let label = createLabel(
      text: attStr,
      frame: CGRect(x: 0, y: 0, width: width, height: size.height))
    label.numberOfLines = 0
    let failure = verifySnapshot(
      matching: label,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testWithinStackView() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: "lclabel://welcome",
      ]))
    let label = LCLabel(frame: .zero)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.backgroundColor = .green
    label.linkStyleValidation = .ensure
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.attributedText = attStr
    label.shouldExcludeUnderlinesFromText = true
    let purpleView = UIView()
    purpleView.backgroundColor = .systemPurple
    let stackView = UIStackView(arrangedSubviews: [
      label,
      purpleView,
    ])
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let view = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 300,
        height: 40))
    view.addSubview(stackView)
    view.backgroundColor = .red
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    let failure = verifySnapshot(
      matching: view,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testWithinVerticalStackView() {
    let text = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet bibendum enim facilisis gravida neque. Orci a scelerisque purus semper eget duis at. Viverra justo nec ultrices dui sapien eget mi proin. Etiam non quam lacus suspendisse faucibus. Vel fringilla est ullamcorper eget nulla facilisi etiam. Donec enim diam vulputate ut pharetra sit amet aliquam id. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Ultrices gravida dictum fusce ut. Nulla aliquet porttitor lacus luctus accumsan tortor posuere ac. Turpis egestas sed tempus urna et pharetra. Pellentesque nec nam aliquam sem et tortor consequat. Risus sed vulputate odio ut enim blandit volutpat maecenas. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa. Blandit massa enim nec dui nunc mattis enim ut. Tristique sollicitudin nibh sit amet.
    """
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: "lclabel://welcome",
      ]))
    let label = LCLabel(frame: .zero)
    label.centeringTextAlignment = .top
    label.backgroundColor = .green
    label.linkStyleValidation = .ensure
    label.linkAttributes = [
      .foregroundColor: UIColor.blue,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.shouldExcludeUnderlinesFromText = true
    label.numberOfLines = 3
    label.attributedText = attStr

    let label2 = LCLabel(frame: .zero)
    label2.centeringTextAlignment = .top
    label2.backgroundColor = .purple
    label2.linkStyleValidation = .ensure
    label2.linkAttributes = [
      .foregroundColor: UIColor.red,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label2.shouldExcludeUnderlinesFromText = true
    label2.numberOfLines = 0
    label2.attributedText = NSAttributedString(
      string: text,
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])

    label.setContentHuggingPriority(.required, for: .vertical)
    label2.setContentCompressionResistancePriority(.required, for: .vertical)

    let stackView = UIStackView(arrangedSubviews: [label, label2])
    stackView.distribution = .fillProportionally
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let view = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 300,
        height: 300))
    view.addSubview(stackView)
    view.backgroundColor = .red
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    let failure = verifySnapshot(
      matching: view,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  func testHiddingView() {
    let attStr = NSMutableAttributedString(
      string: "LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 14),
      ])
    attStr.append(NSAttributedString(
      string: "\n@LCLabel",
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.systemFont(ofSize: 10),
        .link: "lclabel://welcome",
      ]))
    let label = LCLabel(frame: .zero)
    label.centeringTextAlignment = .center
    label.numberOfLines = 2
    label.backgroundColor = .green
    label.linkStyleValidation = .ensure
    label.linkAttributes = [
      .foregroundColor: UIColor.green,
      .font: UIFont.systemFont(ofSize: 12),
    ]
    label.attributedText = attStr
    label.shouldExcludeUnderlinesFromText = true
    let purpleView = UIView()
    purpleView.backgroundColor = .systemPurple
    let stackView = UIStackView(arrangedSubviews: [
      label,
      purpleView,
    ])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let view = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: 300,
        height: 40))
    view.addSubview(stackView)
    view.backgroundColor = .red
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
    label.attributedText = nil
    let failure = verifySnapshot(
      matching: view,
      as: .image,
      snapshotDirectory: path)
    guard let message = failure else { return }
    XCTFail(message)
  }

  // MARK: Private

  private func createLabel(
    text: NSMutableAttributedString,
    frame: CGRect,
    alignment: LCLabel.Alignment = .center,
    numberOfLines: Int = 1) -> LCLabel
  {
    let label = LCLabel(frame: .zero)
    label.frame = frame
    label.centeringTextAlignment = alignment
    label.isUserInteractionEnabled = true
    label.numberOfLines = 1
    label.attributedText = text
    label.backgroundColor = .black
    return label
  }
}

extension XCTestCase {
  var path: String {
    let fileUrl = URL(fileURLWithPath: #file, isDirectory: false)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
    return "\(fileUrl.path)/Sources/LCLabel/LCLabel.docc/Resources/__snapshots__"
  }

}
