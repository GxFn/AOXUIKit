import OSLog

enum UIKitLogger {
    static let app = Logger(
        subsystem: Bundle.main.bundleIdentifier ?? "com.bilidili",
        category: "App"
    )
}
