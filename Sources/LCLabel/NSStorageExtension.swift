// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import UIKit

public extension NSAttributedString.Key {
  static let lclabelLink = NSAttributedString.Key("lclabelLink")
}

extension NSTextStorage {

  func setupStorageWith(
    linkAttributes: [NSAttributedString.Key: Any],
    shouldExcludeUnderlinesFromText: Bool)
  {
    for var range in linksRange {
      let currentAttributes = attributes(
        at: range.lowerBound,
        effectiveRange: &range)
      var mergedAttributes = linkAttributes.merging(
        currentAttributes)
      { key1, key2 in
        key1
      }
      if shouldExcludeUnderlinesFromText {
        mergedAttributes[.underlineStyle] = 0
        mergedAttributes[.underlineColor] = UIColor.clear
      }
      if let link = mergedAttributes[.link] {
        mergedAttributes[.lclabelLink] = link
        mergedAttributes.removeValue(forKey: .link)
      }
      beginEditing()
      removeAttribute(.link, range: range)
      addAttributes(mergedAttributes, range: range)
      endEditing()
    }
  }

  func replaceLinkWithLCLinkAttribute() {
    for var range in linksRange {
      let currentAttributes = attributes(
        at: range.lowerBound,
        effectiveRange: &range)
      guard let link = currentAttributes[.link] else { continue }
      beginEditing()
      removeAttribute(.link, range: range)
      addAttribute(
        .lclabelLink,
        value: link,
        range: range)
      endEditing()
    }
  }

  private var linksRange: [NSRange]  {
    var urlsRange: [NSRange] = []
    let textRange = NSMakeRange(0, length)
    enumerateAttributes(
      in: textRange,
      options: .longestEffectiveRangeNotRequired)
    { dictionary, range, _ in
      if dictionary[.link] != nil {
        urlsRange.append(range)
      }
    }
    return urlsRange
  }
}
