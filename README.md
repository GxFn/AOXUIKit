# AOXUIKit

BiliDili 体系的 UIKit/SwiftUI 展示基础包，提供稳定的宿主边界、加载状态和设计 token，不包含业务路由与网络请求。

## 主要能力

- `AOXHostingController`：把 SwiftUI 页面接回现有 UIKit Coordinator/Tab 架构
- `AOXAsyncStateView`：统一 idle/loading/empty/failed/loaded 状态和重试入口
- `AOXDesignSystem`：颜色、间距、圆角和卡片样式
- `AOXAccessibility`：44pt 点击区、视频/播放/操作的 VoiceOver 文案辅助
- UIKit 基类、Toast、错误呈现、刷新/加载更多与常用视图扩展

AOXUIKit 在 BiliDili 中与 AOXFoundationKit 作为相邻 submodule 使用。独立开发时请把 `AOXFoundationKit` clone 到 `../AOXFoundationKit`。

## 要求与验证

- Swift 6
- iOS 16+

```bash
xcodebuild \
  -scheme AOXUIKit \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=latest' \
  -onlyUsePackageVersionsFromResolvedFile \
  CODE_SIGNING_ALLOWED=NO \
  test
```

仓库提交远端依赖的 `Package.resolved`；本地路径依赖 AOXFoundationKit 由 CI 固定到显式 commit，避免独立验证随 sibling `main` 漂移。

## License

MIT
