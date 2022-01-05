import UIKit

extension CGRect {

  /// Checks if a CGRect has negative values for  width and height
  var isNegative: Bool {
    height < 0 || width < 0
  }

}
