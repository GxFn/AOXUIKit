import XCTest
@testable import AOXUIKit

final class AOXAccessibilityTests: XCTestCase {
    func testMinimumInteractiveDimensionStaysAtComfortablePlatformSize() {
        XCTAssertEqual(AOXAccessibility.minimumInteractiveDimension, 44)
    }

    func testVideoCardLabelIncludesTitleAndAuthor() {
        XCTAssertEqual(
            AOXAccessibility.videoCardLabel(title: "示例视频", author: "测试作者"),
            "示例视频，作者 测试作者"
        )
    }

    func testVideoCardLabelHasUsefulFallbacksForIncompleteModels() {
        XCTAssertEqual(AOXAccessibility.videoCardLabel(title: "示例视频", author: ""), "示例视频")
        XCTAssertEqual(AOXAccessibility.videoCardLabel(title: "", author: "测试作者"), "作者 测试作者")
        XCTAssertEqual(AOXAccessibility.videoCardLabel(title: "", author: ""), "视频")
    }

    func testPlaybackValueDistinguishesManualAndAutoplayStates() {
        XCTAssertEqual(AOXAccessibility.playbackValue(isPlaying: true), "正在播放")
        XCTAssertEqual(AOXAccessibility.playbackValue(isPlaying: false), "已暂停")
        XCTAssertEqual(
            AOXAccessibility.playbackValue(isPlaying: true, isAutoplay: true),
            "正在自动播放"
        )
        XCTAssertEqual(
            AOXAccessibility.playbackValue(isPlaying: false, isAutoplay: true),
            "自动播放已暂停"
        )
    }

    func testActionLabelAvoidsDanglingSeparator() {
        XCTAssertEqual(AOXAccessibility.actionLabel("评论", value: "88 条"), "评论，88 条")
        XCTAssertEqual(AOXAccessibility.actionLabel("分享", value: nil), "分享")
        XCTAssertEqual(AOXAccessibility.actionLabel("分享", value: "  "), "分享")
    }
}
