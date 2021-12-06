import UIKit

@objc extension UIViewController {
    open dynamic func injectDependencies() {

    }
}

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        injectDependencies()
    }
}

open class BaseTableViewController: UITableViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        injectDependencies()
    }
}

open class BaseCollectionViewController: UICollectionViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        injectDependencies()
    }
}

open class BaseTabBarController: UITabBarController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        injectDependencies()
    }
}
