import UIKit

// MARK: - Base Navigation Controller

open class BaseNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }

    /// 状态栏样式由子 VC 决定
    open override var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        topViewController
    }
}
