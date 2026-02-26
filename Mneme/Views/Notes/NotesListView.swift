import SwiftUI

struct NotesListView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        VStack(spacing: 0) {

            // ── Top navigation bar ──
            HStack {
                RoundButton(icon: "line.3.horizontal") {
                    withAnimation { state.sidebarOpen.toggle() }
                }
                Spacer()
                RoundButton(icon: "ellipsis") {}
            }
            .padding(.horizontal, 20)
            .padding(.top, 56)
            .padding(.bottom, 6)

            // ── Screen title ──
            HStack {
                Text(state.selectedFolder.name)
                    .font(.mnemeTitle)
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 14)

            // ── Content list ──
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {

                    // Active notes
                    if !state.folderNotes.isEmpty {
                        WhiteCard {
                            ForEach(Array(state.folderNotes.enumerated()), id: \.element.id) { i, note in
                                NoteRowView(note: note).environmentObject(state)
                                if i < state.folderNotes.count - 1 { RowDivider() }
                            }
                        }
                    }

                    // Completed section
                    if !state.folderCompleted.isEmpty {
                        CompletedSectionView().environmentObject(state)
                    }

                    // View More
                    Text("View More")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 2)
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.bottom, 160)
            }
        }
    }
}
