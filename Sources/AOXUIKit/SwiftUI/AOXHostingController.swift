import SwiftUI
import UIKit

/// SwiftUI Feature 的统一 UIKit 边界。
///
/// AppCoordinator 仍持有 UIViewController，业务页面内部则可以完全使用 SwiftUI；标题、Tab 配置
/// 也集中在这个适配器中，避免每个 Feature 重复嵌套子 HostingController。
@MainActor
open class AOXHostingController<Content: View>: UIHostingController<Content> {
    public init(
        rootView: Content,
        title: String? = nil,
        tabBarTitle: String? = nil,
        tabBarSystemImage: String? = nil,
        tabBarTag: Int = 0
    ) {
        super.init(rootView: rootView)
        self.title = title
        if let tabBarTitle {
            tabBarItem = UITabBarItem(
                title: tabBarTitle,
                image: tabBarSystemImage.flatMap(UIImage.init(systemName:)),
                tag: tabBarTag
            )
        }
    }

    @available(*, unavailable)
    public required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("AOXHostingController 不支持 Storyboard 初始化")
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
