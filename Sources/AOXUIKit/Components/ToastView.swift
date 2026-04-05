import UIKit

// MARK: - Toast View

/// 轻量级 Toast 提示视图，用于统一展示错误/成功消息
public final class ToastView: UIView {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    public init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = UIColor.black.withAlphaComponent(0.78)
        layer.cornerRadius = 8
        clipsToBounds = true

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])

        alpha = 0
    }

    /// 在指定视图上显示 Toast
    public static func show(_ message: String, in view: UIView, duration: TimeInterval = 3.0) {
        let toast = ToastView(message: message)
        view.addSubview(toast)

        toast.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toast.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            toast.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),
        ])

        UIView.animate(withDuration: 0.25) {
            toast.alpha = 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.25, animations: {
                toast.alpha = 0
            }, completion: { _ in
                toast.removeFromSuperview()
            })
        }
    }
}

// MARK: - UIViewController Extension

public extension UIViewController {
    /// 便捷方法：在当前 VC 的 view 上显示 Toast
    func showToast(_ message: String, duration: TimeInterval = 3.0) {
        ToastView.show(message, in: view, duration: duration)
    }

    /// 便捷方法：显示错误 Toast
    func showErrorToast(_ error: Error) {
        showToast(error.localizedDescription)
    }
}
