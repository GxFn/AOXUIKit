import OSLog

extension Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.bilidili"

    /// 应用生命周期（ErrorPresenter 使用）
    static let app = Logger(subsystem: subsystem, category: "App")
}
