import SwiftUI
import Combine

final class AppState: ObservableObject {

    // MARK: - Navigation
    @Published var selectedTab: Int = 0
    @Published var sidebarOpen: Bool = false
    @Published var selectedFolder: Folder = .inbox
    @Published var showAddNote: Bool = false

    // MARK: - Inbox UI
    @Published var completedExpanded: Bool = false
    @Published var showSearch: Bool = false

    // MARK: - Calendar UI
    @Published var calendarDate: Date = .now
    @Published var displayedMonth: Date = .now
    @Published var calendarCompact: Bool = false
    @Published var calendarMode: String = "List"
    @Published var showMoreMenu: Bool = false
    @Published var showViewMenu: Bool = false

    // MARK: - Data
    @Published var folders: [Folder] = Folder.defaultFolders
    @Published var notes: [Note] = Note.sampleNotes

    // MARK: - Derived

    var folderNotes: [Note] {
        notes.filter { $0.folderId == selectedFolder.id && !$0.isCompleted }
    }

    var folderCompleted: [Note] {
        notes.filter { $0.folderId == selectedFolder.id && $0.isCompleted }
    }

    func notes(for date: Date) -> [Note] {
        notes.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func hasNotes(on date: Date) -> Bool {
        notes.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    // MARK: - Mutations

    func addNote(title: String, body: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let note = Note(title: title, body: body, date: .now, folderId: selectedFolder.id)
        notes.insert(note, at: 0)
    }

    func toggleCompletion(_ note: Note) {
        guard let index = notes.firstIndex(of: note) else { return }
        notes[index].isCompleted.toggle()
    }

    func delete(_ note: Note) {
        notes.removeAll { $0.id == note.id }
    }

    func closeAllMenus() {
        showMoreMenu = false
        showViewMenu = false
    }
}
