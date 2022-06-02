import Foundation
import UIKit

extension CGFloat {
  static func random() -> CGFloat {
    CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}
