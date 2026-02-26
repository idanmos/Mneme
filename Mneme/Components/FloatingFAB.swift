import SwiftUI

/// Blue floating action button — bottom-right, above the tab bar
struct FloatingFAB: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 58, height: 58)
                .background(Color.appAccent)
                .clipShape(Circle())
                .shadow(color: Color.appAccent.opacity(0.42), radius: 14, x: 0, y: 5)
        }
        .buttonStyle(.plain)
    }
}
