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


public extension NSAttributedString.Key {
  static let lclabelLink = NSAttributedString.Key("lclabelLink")
}

extension NSTextStorage {

  func setupRenderStorageWith(
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
      beginEditing()
      removeAttribute(.link, range: range)
      addAttribute(
        .lclabelLink,
        value: currentAttributes[.link],
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
