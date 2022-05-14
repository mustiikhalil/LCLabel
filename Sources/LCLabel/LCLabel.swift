// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import UIKit

public protocol LCLabelDelegate: AnyObject {
  func didPress(url: URL, at point: CGPoint)
}

/// LCLabel is a mimic implementation of a UILabel & UITextView.
///
/// LCLabel uses UITextView apis (TextKit) with a low level implemetation
/// to match UILabel. This enables link detection, and simple text display,
/// with paddings.
final public class LCLabel: UIView {

  /// Alignment of the text within LCLabel
  ///
  /// Setting the alignment of the text within LCLabel. This allows the
  /// text to be drawn at  top, bottom or center of the view
  /// ### Top:
  ///  ![](testTextTopAlignment.1)
  /// ### Bottom:
  ///  ![](testTextBottomAlignment.1)
  /// ### Center:
  ///  ![](testTextCenterAlignment.1)
  public enum Alignment {
    /// Aligns the text to the top of the view
    /// keeping insets into consideration
    case top
    /// Aligns the text to the bottom of the view
    /// keeping insets into consideration
    case bottom
    /// Aligns the text to the center of the view
    /// keeping insets into consideration
    case center
  }

  /// Due to TextKit ensuring that links are rendered with default
  /// colors, we need to run some code to revalidate styles
  public enum LinksStyleValidation {
    /// Skip the validation of styles
    case skip
    /// Ensure that the styling matches what's passed
    case ensure
    /// No attributes of type links will be added
    case nolinks
  }

  // MARK: - Variables

  public override var accessibilityTraits: UIAccessibilityTraits {
    get {
      _accessibilityTraits
    }
    set {
      _accessibilityTraits = newValue
    }
  }

  /// A LCLabel delegate that responses to link interactions within
  /// the view
  public weak var delegate: LCLabelDelegate?
  public override var frame: CGRect {
    didSet {
      refreshView()
    }
  }
  /// Text ``Alignment`` within the frame
  public var textAlignment: LCLabel.Alignment = .center {
    didSet {
      refreshView()
    }
  }
  /// Texts inset within the Frame
  public var textInsets: UIEdgeInsets = .zero {
    didSet {
      refreshView()
    }
  }
  /// The attributes to apply to links.
  public var linkAttributes: [NSAttributedString.Key: Any]? {
    didSet {
      guard renderedStorage != nil else { return }
      setupRenderStorage()
      refreshView()
    }
  }
  /// Exclues underlines attributes from text
  public var shouldExcludeUnderlinesFromText = true {
    didSet {
      guard renderedStorage != nil else { return }
      setupRenderStorage()
      refreshView()
    }
  }
  /// Validates if the user passed an attributed string of type .link and switches
  /// it to .lclabelLink
  public var linkStyleValidation: LinksStyleValidation = .skip {
    didSet {
      refreshView()
    }
  }
  /// Line breaking mode the label uses, default is `.byTruncatingTail`
  public var lineBreakMode: NSLineBreakMode = .byTruncatingTail {
    didSet {
      refreshView()
    }
  }
  /// Line padding at the beginning of the view
  public var lineFragmentPadding: CGFloat = 0 {
    didSet {
      refreshView()
    }
  }
  /// Number of lines allowed
  public var numberOfLines = 1 {
    didSet {
      refreshView()
    }
  }
  /// Text to be displayed
  public var attributedText: NSAttributedString? {
    get {
      renderedStorage
    }
    set {
      currentlySelectedLink = nil
      // Removes the current text container since we are resetting it
      if let text = newValue {
        renderedStorage = NSTextStorage(attributedString: text)
        isHidden = false
      } else {
        renderedStorage = nil
        isHidden = true
      }
      accessibilityIdentifier = newValue?.string
      setupRenderStorage()
      refreshView()
    }
  }

  /// Current text to be displayed
  private var renderedStorage: NSTextStorage?
  private var textContainer: NSTextContainer?
  private var currentCalculatedFrame: CGRect?

  /// Current LayoutManager
  private lazy var layoutManager: NSLayoutManager = {
    let layoutManager = NSLayoutManager()
    return layoutManager
  }()

  private var currentlySelectedLink: URL?
  private var _accessibilityTraits: UIAccessibilityTraits

  // MARK: - Life Cycle

  public convenience init() {
    self.init(frame: .zero)
  }

  public override init(frame: CGRect) {
    _accessibilityTraits = .staticText
    super.init(frame: frame)
  }

  public required init?(coder: NSCoder) {
    fatalError("Coder init isnt supported here.")
  }

  // MARK: - Implementation

  public override func draw(_ rect: CGRect) {
    super.draw(rect)

    guard let storage = renderedStorage, !storage.string.isEmpty else
    {
      return
    }

    let bounds = textRect(forBounds: rect)

    currentCalculatedFrame = bounds

    let container: NSTextContainer
    // Check if the current text container is still valid
    // with the proper size.
    if let textContainer = textContainer,
       textContainer.size == bounds.size
    {
      container = textContainer
    } else {
      // Removes the current text container and replace it with a newer one
      if !layoutManager.textContainers.isEmpty {
        layoutManager.removeTextContainer(at: 0)
      }
      container = NSTextContainer(size: bounds.size)
      layoutManager.addTextContainer(container)
    }
    container.maximumNumberOfLines = numberOfLines
    container.lineBreakMode = lineBreakMode
    container.lineFragmentPadding = lineFragmentPadding
    storage.addLayoutManager(layoutManager)
    let range = layoutManager.glyphRange(for: container)

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
    guard let text = renderedStorage else {
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

  private func refreshView() {
    setNeedsDisplay()
    setNeedsLayout()
  }

  /// The following functions replaces
  private func setupRenderStorage() {
    guard let renderedStorage = renderedStorage else { return }
    switch linkStyleValidation {
    case .ensure:
      if let linkAttributes = linkAttributes {
        renderedStorage.setupStorageWith(
          linkAttributes: linkAttributes,
          shouldExcludeUnderlinesFromText: shouldExcludeUnderlinesFromText)
      } else {
        renderedStorage.replaceLinkWithLCLinkAttribute()
      }
    case .skip, .nolinks:
      break
    }
  }
}

// MARK: - Touch APIS

extension LCLabel {

  public override var canBecomeFirstResponder: Bool {
    true
  }

  public override func hitTest(
    _ point: CGPoint,
    with event: UIEvent?) -> UIView?
  {
    let link = getLink(at: point)
    if link == nil || !isUserInteractionEnabled || isHidden {
      return super.hitTest(point, with: event)
    }
    return self
  }

  public override func touchesBegan(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    currentlySelectedLink = linkAt(touches)
    if currentlySelectedLink == nil {
      super.touchesBegan(touches, with: event)
    }
  }

  public override func touchesMoved(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if let currentlySelectedLink = currentlySelectedLink,
       currentlySelectedLink != linkAt(touches)
    {
      self.currentlySelectedLink = nil
    } else {
      super.touchesMoved(touches, with: event)
    }
  }

  public override func touchesEnded(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if let currentSelectedLink = currentlySelectedLink {
      currentlySelectedLink = nil
      if let touch = touches.first {
        delegate?.didPress(
          url: currentSelectedLink,
          at: touch.location(in: self))
      }
    } else {
      super.touchesEnded(touches, with: event)
    }
  }

  public override func touchesCancelled(
    _ touches: Set<UITouch>,
    with event: UIEvent?)
  {
    if currentlySelectedLink != nil {
      currentlySelectedLink = nil
    } else {
      super.touchesCancelled(touches, with: event)
    }
  }

  private func linkAt(_ touches: Set<UITouch>) -> URL? {
    guard let touch = touches.first else { return nil }
    return getLink(at: touch.location(in: self))
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
    // (Note): we are using attachment since i couldnt remove the default
    // link coloring with TextKit
    guard let url = renderedStorage?.attribute(
      .lclabelLink,
      at: index,
      effectiveRange: nil)
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
