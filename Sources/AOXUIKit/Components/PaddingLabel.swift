import UIKit

// MARK: - Padding Label

/// 带内边距的 UILabel，用于时长胶囊、角标等需要文字四周留白的场景。
/// UILabel 原生不支持 contentInsets，此前各处用「首尾空格」或无背景硬贴边，样式不统一；
/// 统一用本组件承载半透明圆角胶囊，避免空格 hack 与三处封面时长风格不一致。
public final class PaddingLabel: UILabel {

    /// 文字四周内边距
    public var textInsets = UIEdgeInsets(top: 1.5, left: 5, bottom: 1.5, right: 5) {
        didSet { invalidateIntrinsicContentSize() }
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    public override var intrinsicContentSize: CGSize {
        padded(super.intrinsicContentSize)
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        padded(super.sizeThatFits(size))
    }

    private func padded(_ size: CGSize) -> CGSize {
        CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }

    /// 快速配置成半透明黑色圆角时长胶囊（B 站封面右下角样式）
    public static func durationBadge() -> PaddingLabel {
        let label = PaddingLabel()
        label.font = .monospacedDigitSystemFont(ofSize: 11, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        return label
    }
}
