import UIKit
import OSLog
import AOXFoundationKit

// MARK: - Error Presenter

/// 统一错误展示策略
/// 自动从 UserFacingError 协议获取用户友好文案
public enum ErrorPresenter {

    public enum Level {
        /// 轻提示（默认）
        case toast
        /// 仅日志，不展示给用户
        case silent
    }

    /// 统一处理错误
    @MainActor
    public static func present(
        _ error: Error,
        level: Level = .toast,
        in viewController: UIViewController? = nil
    ) {
        let message = error.userFacingMessage

        switch level {
        case .toast:
            let vc = viewController ?? topViewController()
            vc?.showToast(message)
        case .silent:
            break
        }

        Logger.app.error("ErrorPresenter [\(String(describing: level))]: \(error.localizedDescription)")
    }

    /// 获取当前最顶层的 ViewController
    @MainActor
    private static func topViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let rootVC = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return nil
        }

        var top: UIViewController? = rootVC
        while let presented = top?.presentedViewController {
            top = presented
        }
        // 穿透 UITabBarController
        if let tab = top as? UITabBarController {
            top = tab.selectedViewController
        }
        // 穿透 UINavigationController
        if let nav = top as? UINavigationController {
            top = nav.visibleViewController
        }
        return top
    }
}

// MARK: - UIViewController Extension

public extension UIViewController {
    /// 展示错误（自动走 UserFacingError 协议获取文案）
    func presentError(_ error: Error) {
        ErrorPresenter.present(error, in: self)
    }
}
