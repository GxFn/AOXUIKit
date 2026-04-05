import UIKit

// MARK: - Gradient View

/// 渐变遮罩视图，常用于视频封面底部文字保护
public final class GradientView: UIView {
    public enum Direction {
        case topToBottom
        case bottomToTop
    }

    private let gradientLayer = CAGradientLayer()

    public init(direction: Direction = .bottomToTop, colors: [UIColor] = [.clear, .black.withAlphaComponent(0.6)]) {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        gradientLayer.colors = colors.map(\.cgColor)
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        }
        layer.addSublayer(gradientLayer)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
