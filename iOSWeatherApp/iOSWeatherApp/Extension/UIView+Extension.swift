import UIKit
import Foundation

public extension UIView {

    static var identifier: String {
        return "\(self)"
    }

    var identifier: String {
        return String(describing: type(of: self))
    }
}
