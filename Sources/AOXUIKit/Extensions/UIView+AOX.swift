import UIKit

// MARK: - UIView Utilities

public extension UIView {
    /// 添加圆角
    func aox_cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    /// 添加阴影
    func aox_shadow(color: UIColor = .black, opacity: Float = 0.1, offset: CGSize = .init(width: 0, height: 2), radius: CGFloat = 4) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}
