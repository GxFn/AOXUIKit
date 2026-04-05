import UIKit

// MARK: - Base View Controller

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
    }

    /// 子类重写以设置 UI
    open func setupUI() {}

    /// 子类重写以绑定 ViewModel
    open func bindViewModel() {}
}
