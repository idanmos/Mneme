import UIKit

final class HapticManager {

    static let shared = HapticManager()

    private init() {}

    /// Light impact — used for taps and selections.
    func lightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    /// Medium impact — used for task completion.
    func mediumImpact() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    /// Success notification — used after completing an action.
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    /// Selection changed — used for picker changes, drag reordering.
    func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
