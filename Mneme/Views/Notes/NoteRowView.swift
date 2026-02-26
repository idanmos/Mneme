import SwiftUI

struct NoteRowView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences
    let note: Note

    var body: some View {
        HStack(alignment: .center, spacing: 12) {

            // ── Checkbox ──
            Button { state.toggleCompletion(note, preferences: preferences) } label: {
                Image(systemName: note.isCompleted ? "checkmark.square.fill" : "square")
                    .font(.system(size: 19))
                    .foregroundColor(
                        note.isCompleted
                            ? Color(hex: "C7C7CC")
                            : Color(hex: "AEAEB2")
                    )
            }
            .buttonStyle(.plain)

            // ── Title ──
            Text(note.title)
                .font(.mnemeBody)
                .foregroundColor(note.isCompleted ? .textSecondary : .textPrimary)
                .lineLimit(1)

            Spacer()

            // ── Date label ──
            if let label = note.shortDateLabel {
                Text(label)
                    .font(.mnemeCaption)
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, Spacing.rowVertical)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                state.delete(note)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
