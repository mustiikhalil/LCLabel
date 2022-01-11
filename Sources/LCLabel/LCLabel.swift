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

import UIKit

public enum LCLabelTextAlignment {
  case top, bottom, center
}

public protocol LCLabelDelegate: AnyObject {
  func didPress(url: URL, at point: CGPoint)
}

/// LCLabel is a mimic implementation of a UILabel & UITextView.
///
/// LCLabel uses UITextView apis (TextKit) with a low level implemetation
/// to match UILabel. This enables link detection, and simple text display,
/// with paddings.
final public class LCLabel: UIView {

  // MARK: - Variables
  public weak var delegate: LCLabelDelegate?
  /// Alignment within the actual frame
  public var textAlignment: LCLabelTextAlignment = .center
  /// UIEdgeInsets for insetting the text within the Frame
  public var textInsets: UIEdgeInsets = .zero {
    didSet {
      layoutIfNeeded()
      setNeedsLayout()
      setNeedsDisplay()
    }
  }
  /// Line breaking mode the label uses, default is `.byTruncatingTail`
  public var lineBreakMode: NSLineBreakMode = .byTruncatingTail
  /// Number of lines allowed
  public var numberOfLines: Int = 1
  /// Text to be displayed
  public var attributedText: NSAttributedString? {
    get {
      storage
    }
    set {
      // Removes the current text container since we are resetting it
      if let text = newValue {
        storage = NSTextStorage(attributedString: text)
        isHidden = false
      } else {
        storage = nil
        isHidden = true
      }
      layoutIfNeeded()
      setNeedsLayout()
      setNeedsDisplay()
    }
  }
  /// Current text to be displayed
  var storage: NSTextStorage?

  private var currentCalculatedFrame: CGRect?

  /// Current LayoutManager
  private lazy var layoutManager: NSLayoutManager = {
    let layoutManager = NSLayoutManager()
    layoutManager.allowsNonContiguousLayout = false
    return layoutManager
  }()

  private var textContainer: NSTextContainer?

  // MARK: - Life Cycle

  public init() {
    super.init(frame: .zero)
    setupLabel()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupLabel()
  }

  public required init?(coder: NSCoder) {
    fatalError("Coder init isnt supported here.")
  }

  // MARK: - Implementation

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    guard let storage = storage, let attStr = attributedText,
          !attStr.string.isEmpty else
    {
      return
    }

    // Removes the current text container and replace it with a newer one
    if !layoutManager.textContainers.isEmpty {
      layoutManager.removeTextContainer(at: 0)
    }

    let range = NSMakeRange(0, attStr.length)
    let bounds = textRect(forBounds: rect)

    currentCalculatedFrame = bounds
    let container = NSTextContainer(size: bounds.size)
    container.maximumNumberOfLines = numberOfLines
    container.lineBreakMode = lineBreakMode
    layoutManager.addTextContainer(container)
    storage.addLayoutManager(layoutManager)

    layoutManager.ensureGlyphs(
      forGlyphRange: range)

    layoutManager.drawBackground(
      forGlyphRange: range,
      at: bounds.origin)

    layoutManager.drawGlyphs(
      forGlyphRange: range,
      at: bounds.origin)
  }

  private func textRect(forBounds bounds: CGRect) -> CGRect {
    // We inset the bounds with the users textInsets
    var newBounds = bounds.inset(by: textInsets)
    assert(
      !newBounds.isNegative,
      "The new bounds are negative with isnt allowed, check the frame or the textInsets")
    guard let text = storage else {
      return .zero
    }

    let calculatedHeight = text.boundingRect(
      with: newBounds.size, options: .usesLineFragmentOrigin, context: nil)
    switch textAlignment {
    case .center:
      newBounds.origin.y = (newBounds.height - calculatedHeight.height) / 2
    case .bottom:
      newBounds.origin.y = (newBounds.height - calculatedHeight.height)
    case .top:
      break
    }
    return newBounds
  }

  private func setupLabel() {
    let tapGesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(handleUserInput))
    tapGesture.delegate = self
    addGestureRecognizer(tapGesture)
  }
}

// MARK: - Touch APIS

extension LCLabel {

  public override var canBecomeFirstResponder: Bool {
    true
  }

  public override func touchesBegan(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if isTouchable(touches) {
      super.touchesBegan(touches, with: event)
    }
  }

  public override func touchesMoved(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if isTouchable(touches) {
      super.touchesMoved(touches, with: event)
    }
  }

  public override func touchesEnded(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if isTouchable(touches) {
      super.touchesEnded(touches, with: event)
    }
  }

  private func isTouchable(_ touches: Set<UITouch>) -> Bool {
    guard let touch = touches.first else { return false }
    return getLink(at: touch.location(in: self)) == nil
  }

}

// MARK: - UIGestureRecognizerDelegate

extension LCLabel: UIGestureRecognizerDelegate {

  public override func gestureRecognizerShouldBegin(
    _ gestureRecognizer: UIGestureRecognizer)
    -> Bool
  {
    isUserInteractionEnabled
  }

  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldReceive touch: UITouch) -> Bool
  {
    let point = touch.location(in: self)
    checkoutLink(at: point)
    return false
  }

  @objc
  private func handleUserInput(_ gesture: UILongPressGestureRecognizer) {
    let point = gesture.location(in: self)
    switch gesture.state {
    case .began:
      checkoutLink(at: point)
    default:
      break
    }
  }

  private func checkoutLink(at point: CGPoint) {
    guard let url = getLink(at: point) else {
      return
    }
    delegate?.didPress(url: url, at: point)
  }

  private func getLink(at point: CGPoint) -> URL? {
    // Check if the point is within the bounds of the text
    // container before converting it
    guard
      let currentCalculatedFrame = currentCalculatedFrame,
      currentCalculatedFrame.contains(point) else
    {
      return nil
    }
    // converting the input point into the inner X,Y plain.
    let _point = CGPoint(
      x: point.x - currentCalculatedFrame.minX,
      y: point.y - currentCalculatedFrame.minY)

    guard let container = layoutManager.textContainers.first else {
      return nil
    }
    // Get the index of the character at point
    let index = layoutManager.characterIndex(
      for: _point,
      in: container,
      fractionOfDistanceBetweenInsertionPoints: nil)
    // Get the link from the storage since we know its going to be a
    // .link attribute at an index (x)
    guard let url = storage?.attribute(.link, at: index, effectiveRange: nil)
    else {
      return nil
    }
    // Return url of the type of link is a url
    if let url = url as? URL {
      return url
    }
    // Returns a url if it can be translated to a url
    guard let _url = url as? String, let url = URL(string: _url) else {
      return nil
    }
    return url
  }

}
