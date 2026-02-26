import SwiftUI

/// White rounded card with subtle shadow — wraps list rows
struct WhiteCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

/// Indented divider for inside WhiteCard rows
struct RowDivider: View {
    var leadingPadding: CGFloat = 52

    var body: some View {
        Divider()
            .padding(.leading, leadingPadding)
    }
}
