import UIKit
import Testing
@testable import AOXUIKit

@MainActor
struct PaddingLabelLayoutTests {
    @Test func multilineMeasurementReservesPaddingBeforeWrapping() {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = "Alpha beta gamma delta epsilon zeta eta theta"
        label.textInsets = UIEdgeInsets(top: 6, left: 20, bottom: 6, right: 20)
        let reference = UILabel()
        reference.font = label.font
        reference.numberOfLines = label.numberOfLines
        reference.text = label.text

        let available = CGSize(width: 140, height: 1000)
        let textSize = reference.sizeThatFits(CGSize(width: 100, height: 988))
        let measured = label.sizeThatFits(available)
        #expect(measured.width <= available.width)
        #expect(abs(measured.height - (textSize.height + 12)) < 0.5)
    }
}
