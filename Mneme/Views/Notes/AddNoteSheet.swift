import SwiftUI

struct AddNoteSheet: View {
    @EnvironmentObject var state: AppState
    @State private var titleText: String = ""
    @State private var bodyText:  String = ""
    @FocusState private var titleFocused: Bool

    private var placeholder: String {
        state.selectedTab == 1 ? "What would you like to do?".localized : "Prepare monthly report".localized
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Title field — blue tinted placeholder ──
            TextField(
                "",
                text: $titleText,
                prompt: Text(placeholder).foregroundColor(Color.appAccent.opacity(0.6))
            )
            .font(.system(size: 16))
            .foregroundColor(.appAccent)
            .focused($titleFocused)
            .padding(.horizontal, 18)
            .padding(.top, 20)

            // ── Description field ──
            TextField(
                "",
                text: $bodyText,
                prompt: Text("Description".localized).foregroundColor(.textSecondary)
            )
            .font(.system(size: 14))
            .foregroundColor(.textPrimary)
            .padding(.horizontal, 18)
            .padding(.top, 8)

            Spacer()

            Divider()

            // ── Toolbar ──
            HStack(spacing: 0) {
                ToolbarButton(icon: "keyboard")
                ToolbarButton(icon: "flag")
                ToolbarButton(icon: "tag")
                ToolbarButton(icon: "list.bullet.rectangle")
                ToolbarButton(icon: "ellipsis")

                // Calendar tab shows "Today" label
                if state.selectedTab == 1 {
                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.system(size: 17))
                            .foregroundColor(.appAccent)
                        Text("Today".localized)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.appAccent)
                    }
                    .padding(.leading, 6)
                }

                Spacer()

                Image(systemName: "mic")
                    .font(.system(size: 22))
                    .foregroundColor(.textSecondary.opacity(0.45))
                    .padding(.trailing, 16)
            }
            .padding(.leading, 8)
            .padding(.vertical, 12)
        }
        .background(Color.cardBackground)
        .onAppear { titleFocused = true }
    }
}

// MARK: - Toolbar icon button

private struct ToolbarButton: View {
    let icon: String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 19))
            .foregroundColor(Color(hex: "AEAEB2").opacity(0.7))
            .frame(width: 44, height: 44)
    }
}
