import SwiftUI
import UIKit

// MARK: - SwiftUI Design Tokens

/// AOX UIKit / SwiftUI 共用的设计令牌。
///
/// 颜色继续以既有 UIColor 定义为唯一来源，宿主修改 `aox_tint` 后，SwiftUI 页面也会同步生效，
/// 避免迁移过程中出现两套主题配置。
public enum AOXColor {
    public static var tint: Color { Color(uiColor: .aox_tint) }
    public static var text: Color { Color(uiColor: .aox_text) }
    public static var secondaryText: Color { Color(uiColor: .aox_textSecondary) }
    public static var separator: Color { Color(uiColor: .aox_separator) }
    public static var background: Color { Color(uiColor: .aox_background) }
    public static var groupedBackground: Color { Color(uiColor: .systemGroupedBackground) }
    public static var cardBackground: Color { Color(uiColor: .secondarySystemGroupedBackground) }
    public static var placeholder: Color { Color(uiColor: .systemFill) }
}

public enum AOXSpacing {
    public static let xSmall: CGFloat = 4
    public static let small: CGFloat = 8
    public static let medium: CGFloat = 12
    public static let large: CGFloat = 16
    public static let xLarge: CGFloat = 24
}

public enum AOXCornerRadius {
    public static let small: CGFloat = 6
    public static let medium: CGFloat = 8
    public static let large: CGFloat = 12
}

public extension View {
    /// 统一视频卡片的背景、圆角与轻量阴影，保持 UIKit 迁移前后的层级感一致。
    func aoxCardStyle(cornerRadius: CGFloat = AOXCornerRadius.medium) -> some View {
        background(AOXColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.primary.opacity(0.06), radius: 4, y: 1)
    }
}
