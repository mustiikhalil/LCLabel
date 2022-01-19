// Copyright (c) Mustafa Khalil. and contributors.
//
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import UIKit

extension CGRect {

  /// Checks if a CGRect has negative values for  width and height
  var isNegative: Bool {
    height < 0 || width < 0
  }

}
