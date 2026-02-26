import SwiftUI

struct CompletedSectionView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        WhiteCard {

            // ── Header (always visible, tap to toggle) ──
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    state.completedExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Completed")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Spacer()

                    Text("\(state.folderCompleted.count)")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)

                    Image(systemName: state.completedExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                }
                .padding(.horizontal, Spacing.cardPadding)
                .padding(.vertical, Spacing.rowVertical)
            }
            .buttonStyle(.plain)

            // ── Completed note rows (always shown matching screenshots) ──
            ForEach(Array(state.folderCompleted.enumerated()), id: \.element.id) { _, note in
                RowDivider()
                NoteRowView(note: note).environmentObject(state)
            }
        }
    }
}
