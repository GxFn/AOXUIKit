import SwiftUI

/// 页面级异步状态。失败态保存可直接展示的用户文案，不向视图泄漏网络错误类型。
public enum AOXLoadState: Equatable, Sendable {
    case idle
    case loading
    case loaded
    case empty(message: String)
    case failed(message: String)
}

/// 统一加载、空态、错误和内容呈现，迁移后的 Feature 只负责业务数据与重试动作。
public struct AOXAsyncStateView<Content: View>: View {
    private let state: AOXLoadState
    private let retry: (() -> Void)?
    private let content: Content

    public init(
        state: AOXLoadState,
        retry: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.state = state
        self.retry = retry
        self.content = content()
    }

    public var body: some View {
        switch state {
        case .idle, .loading:
            VStack(spacing: AOXSpacing.medium) {
                ProgressView()
                    .tint(AOXColor.tint)
                    .accessibilityLabel("正在加载内容")
                Text("正在加载…")
                    .font(.footnote)
                    .foregroundStyle(AOXColor.secondaryText)
                    .accessibilityHidden(true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded:
            content

        case let .empty(message):
            stateMessage(
                systemImage: "tray",
                title: message,
                retryTitle: "刷新"
            )

        case let .failed(message):
            stateMessage(
                systemImage: "exclamationmark.triangle",
                title: message,
                retryTitle: "重试"
            )
        }
    }

    @ViewBuilder
    private func stateMessage(systemImage: String, title: String, retryTitle: String) -> some View {
        VStack(spacing: AOXSpacing.medium) {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundStyle(AOXColor.secondaryText)
                .accessibilityHidden(true)
            Text(title)
                .font(.callout)
                .foregroundStyle(AOXColor.secondaryText)
                .multilineTextAlignment(.center)
                .accessibilityLabel(title)
            if let retry {
                Button(retryTitle, action: retry)
                    .buttonStyle(.borderedProminent)
                    .tint(AOXColor.tint)
                    .aoxMinimumInteractiveSize()
                    .accessibilityHint("重新请求当前页面内容")
            }
        }
        .padding(AOXSpacing.xLarge)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
