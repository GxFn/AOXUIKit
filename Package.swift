// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AOXUIKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "AOXUIKit", targets: ["AOXUIKit"]),
    ],
    dependencies: [
        .package(path: "../AOXFoundationKit"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.0.0"),
    ],
    targets: [
        .target(
            name: "AOXUIKit",
            dependencies: [
                "AOXFoundationKit",
                "SnapKit",
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                "Kingfisher",
            ],
            path: "Sources/AOXUIKit"
        ),
    ]
)
