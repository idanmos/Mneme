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

            // ── Screen title with folder icon ──
            HStack(spacing: 10) {
                Image(systemName: state.selectedFolder.sfSymbol)
                    .font(.system(size: 26))
                    .foregroundColor(state.selectedFolder.iconColor == .white
                                    ? .textPrimary
                                    : state.selectedFolder.iconColor)
                Text(state.selectedFolder.name)
                    .font(.mnemeTitle)
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 14)

            // ── Tappable search bar ──
            Button {
                state.showSearch = true
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                    Text("Search")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(hex: "E8E8ED"))
                .cornerRadius(10)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.bottom, 10)

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
