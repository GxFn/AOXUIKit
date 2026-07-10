import SwiftUI
import UIKit

// MARK: - SwiftUI Design Tokens

/// AOX UIKit / SwiftUI 共用的设计令牌。
///
/// 颜色继续以既有 UIColor 定义为唯一来源，宿主修改 `aox_tint` 后，SwiftUI 页面也会同步生效，
/// 避免迁移过程中出现两套主题配置。
public enum AOXColor {
    @MainActor public static var tint: Color { Color(uiColor: .aox_tint) }
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

/// VoiceOver 与可点击尺寸的共用策略。
///
/// 文案生成保持为纯函数，Feature 可以复用同一套朗读语义，也便于不启动 UI 的单元测试覆盖。
public enum AOXAccessibility {
    /// Apple 平台通用的最小舒适点击尺寸，图标本身可以更小，但命中区域不能更小。
    public static let minimumInteractiveDimension: CGFloat = 44

    public static func videoCardLabel(title: String, author: String) -> String {
        let normalizedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedAuthor = author.trimmingCharacters(in: .whitespacesAndNewlines)

        switch (normalizedTitle.isEmpty, normalizedAuthor.isEmpty) {
        case (false, false):
            return "\(normalizedTitle)，作者 \(normalizedAuthor)"
        case (false, true):
            return normalizedTitle
        case (true, false):
            return "作者 \(normalizedAuthor)"
        case (true, true):
            return "视频"
        }
    }

    public static func playbackValue(isPlaying: Bool, isAutoplay: Bool = false) -> String {
        if isAutoplay {
            return isPlaying ? "正在自动播放" : "自动播放已暂停"
        }
        return isPlaying ? "正在播放" : "已暂停"
    }

    public static func actionLabel(_ action: String, value: String? = nil) -> String {
        guard let value = value?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return action
        }
        return "\(action)，\(value)"
    }
}

public extension View {
    /// 统一视频卡片的背景、圆角与轻量阴影，保持 UIKit 迁移前后的层级感一致。
    func aoxCardStyle(cornerRadius: CGFloat = AOXCornerRadius.medium) -> some View {
        background(AOXColor.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .shadow(color: Color.primary.opacity(0.06), radius: 4, y: 1)
    }

    /// 扩大图标按钮的命中区域，同时不强迫调用方把视觉图标放大到 44pt。
    func aoxMinimumInteractiveSize() -> some View {
        frame(
            minWidth: AOXAccessibility.minimumInteractiveDimension,
            minHeight: AOXAccessibility.minimumInteractiveDimension
        )
        .contentShape(Rectangle())
    }
}
