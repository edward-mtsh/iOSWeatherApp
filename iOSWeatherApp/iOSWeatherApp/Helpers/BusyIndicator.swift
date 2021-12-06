import UIKit
import Foundation

var activityView = UIActivityIndicatorView(style: .large)

extension UIViewController {
    
    func showBusyView() {
        activityView.center = self.view.center
        activityView.color = UIColor.darkGray
        activityView.startAnimating()
        self.view.addSubview(activityView)
        let x = (UIScreen.main.bounds.width / 2)
        let y = (UIScreen.main.bounds.height / 2)
        activityView.center = CGPoint( x: x, y: y)
    }
    
    func hideBusyView() {
        activityView.stopAnimating()
        activityView.isHidden = true
        activityView.removeFromSuperview()
    }
}
