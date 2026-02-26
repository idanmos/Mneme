import SwiftUI

/// Circular white button with shadow — used in top navigation bars
struct RoundButton: View {
    let icon: String
    var size: CGFloat = 42
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.textPrimary)
                .frame(width: size, height: size)
                .background(Color.cardBackground)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}
