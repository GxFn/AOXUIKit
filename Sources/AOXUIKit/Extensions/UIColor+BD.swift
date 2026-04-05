import UIKit

// MARK: - UIColor Convenience

public extension UIColor {
    /// 十六进制颜色
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }

    /// Bilibili 品牌粉色
    static let bd_pink = UIColor(hex: 0xFB7299)
    /// 主文字色
    static let bd_text = UIColor.label
    /// 次要文字色
    static let bd_textSecondary = UIColor.secondaryLabel
    /// 分割线颜色
    static let bd_separator = UIColor.separator
    /// 背景色
    static let bd_background = UIColor.systemBackground
}
