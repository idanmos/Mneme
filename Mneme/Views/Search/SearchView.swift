import SwiftUI

struct SearchView: View {
    @EnvironmentObject var state: AppState
    @State private var searchText: String = ""
    @FocusState private var searchFocused: Bool

    private var matchingNotes: [Note] {
        guard !searchText.isEmpty else { return [] }
        let query = searchText
        return state.notes.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.body.localizedCaseInsensitiveContains(query)
        }
    }

    private var matchingFolders: [Folder] {
        guard !searchText.isEmpty else { return [] }
        let query = searchText
        return state.folders.filter {
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Search bar + close button ──
            HStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                    TextField("Search", text: $searchText)
                        .font(.system(size: 16))
                        .focused($searchFocused)
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.textSecondary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color(hex: "E8E8ED"))
                .cornerRadius(10)

                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        state.showSearch = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.textPrimary)
                        .frame(width: 36, height: 36)
                        .background(Color.cardBackground)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 2)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 18)
            .padding(.top, 60)
            .padding(.bottom, 16)

            if searchText.isEmpty {
                // ── Empty state ──
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "binoculars.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.appAccent.opacity(0.3))
                    Text("What do you want to search")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.textPrimary)
                    Text("Tap the input box to search")
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                }
                Spacer()
                Spacer()
            } else {
                // ── Results ──
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {

                        // Tasks section
                        if !matchingNotes.isEmpty {
                            WhiteCard {
                                HStack {
                                    Text("Tasks")
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer()
                                }
                                .padding(.horizontal, Spacing.cardPadding)
                                .padding(.top, 14)
                                .padding(.bottom, 4)

                                ForEach(Array(matchingNotes.prefix(5).enumerated()), id: \.element.id) { i, note in
                                    if i > 0 { RowDivider(leadingPadding: 16) }
                                    SearchResultRow(note: note, folder: folderFor(note))
                                }

                                if matchingNotes.count > 5 {
                                    Divider()
                                    Text("View More")
                                        .font(.system(size: 14))
                                        .foregroundColor(.appAccent)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.vertical, 12)
                                }
                            }
                        }

                        // Folders section
                        if !matchingFolders.isEmpty {
                            WhiteCard {
                                HStack {
                                    Text("List")
                                        .font(.system(size: 16, weight: .bold))
                                    Spacer()
                                }
                                .padding(.horizontal, Spacing.cardPadding)
                                .padding(.top, 14)
                                .padding(.bottom, 4)

                                ForEach(Array(matchingFolders.enumerated()), id: \.element.id) { i, folder in
                                    if i > 0 { RowDivider(leadingPadding: 16) }
                                    HStack(spacing: 12) {
                                        Image(systemName: folder.sfSymbol)
                                            .font(.system(size: 16))
                                            .foregroundColor(folder.iconColor == .white
                                                             ? .textPrimary
                                                             : folder.iconColor)
                                            .frame(width: 24)
                                        Text(folder.name)
                                            .font(.mnemeBody)
                                            .foregroundColor(.textPrimary)
                                        Spacer()
                                    }
                                    .padding(.horizontal, Spacing.cardPadding)
                                    .padding(.vertical, Spacing.rowVertical)
                                    .onTapGesture {
                                        state.selectedFolder = folder
                                        state.selectedTab = 0
                                        withAnimation { state.showSearch = false }
                                    }
                                }
                            }
                        }

                        if matchingNotes.isEmpty && matchingFolders.isEmpty {
                            VStack(spacing: 8) {
                                Text("No results")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.textPrimary)
                                Text("Try a different search term")
                                    .font(.system(size: 14))
                                    .foregroundColor(.textSecondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        }
                    }
                    .padding(.horizontal, Spacing.screenHorizontal)
                    .padding(.bottom, 40)
                }
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear { searchFocused = true }
    }

    private func folderFor(_ note: Note) -> Folder? {
        state.folders.first { $0.id == note.folderId }
    }
}

// MARK: - Search Result Row

private struct SearchResultRow: View {
    let note: Note
    let folder: Folder?

    /// Border color: blue for calendar events, accent for others
    private var borderColor: Color {
        if note.isCalendarEvent { return .calendarBlue }
        return .appAccent
    }

    /// Date label: "Today, HH:mm - HH:mm" for events, "d MMM" for others
    private var dateLabel: String {
        if note.isCalendarEvent, let range = note.eventRange {
            return note.date.isToday ? "Today, \(range)" : "\(note.date.shortLabel), \(range)"
        }
        return note.date.isToday ? "Today" : note.date.shortLabel
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            // Colored left border
            Rectangle()
                .fill(borderColor)
                .frame(width: 3)
                .padding(.vertical, 4)

            // Icon
            Image(systemName: note.isCalendarEvent ? "calendar.badge.clock" : "checkmark.circle")
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
                .frame(width: 28)
                .padding(.top, 2)

            // Content
            VStack(alignment: .leading, spacing: 3) {
                Text(note.title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.textPrimary)
                    .lineLimit(1)
                Text(dateLabel)
                    .font(.system(size: 12))
                    .foregroundColor(.appAccent)
            }

            Spacer()

            if note.isRecurring {
                Image(systemName: "repeat")
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary.opacity(0.5))
                    .padding(.top, 4)
            }
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, 10)
    }
}
