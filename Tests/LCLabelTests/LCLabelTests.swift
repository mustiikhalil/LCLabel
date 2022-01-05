import SnapshotTesting
import XCTest
@testable import LCLabel

final class LCLabelTests: XCTestCase {

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
    label.textAlignment = .top
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
    label.textAlignment = .bottom
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

  private func createLabel(
    text: NSMutableAttributedString,
    frame: CGRect,
    alignment: LCLabelTextAlignment = .center,
    numberOfLines: Int = 1) -> LCLabel
  {
    let label = LCLabel(frame: .zero)
    label.frame = frame
    label.textAlignment = alignment
    label.isUserInteractionEnabled = true
    label.numberOfLines = 1
    label.attributedText = text
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
