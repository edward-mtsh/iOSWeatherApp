import UIKit
import Foundation

extension UIViewController {
    
    func showErrorMessage(library: MessageLibrary) {
        self.onMainThread {
            let alert = UIAlertController(title: library.title, message: library.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showErrorMessage(title: String, message:String) {
        self.onMainThread {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
