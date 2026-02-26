import SwiftUI

struct Note: Identifiable, Equatable {
    var id: UUID = UUID()
    var title: String
    var body: String = ""
    var date: Date = .now
    var folderId: UUID
    var isCompleted: Bool = false
    var isRecurring: Bool = false
    var hasAlarm: Bool = false
    var isCalendarEvent: Bool = false   // subscribed calendar (shows blue left border)
    var eventRange: String? = nil       // e.g. "12:00 - 13:00"

    // MARK: - Computed

    /// Short date label shown on the right side of a note row.
    /// Returns nil if the note is from today.
    var shortDateLabel: String? {
        guard !Calendar.current.isDateInToday(date) else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }

    /// HH:mm time string
    var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

// MARK: - Sample data

extension Note {
    static var sampleNotes: [Note] {
        let cal = Calendar.current

        func daysAgo(_ n: Int) -> Date {
            cal.date(byAdding: .day, value: -n, to: .now)!
        }

        func todayAt(_ hour: Int) -> Date {
            cal.date(bySettingHour: hour, minute: 0, second: 0, of: .now)!
        }

        return [
            // ── Inbox completed ──
            Note(title: "לסמן במערכת יום חופש על אתמול",
                 date: daysAgo(1), folderId: Folder.inbox.id, isCompleted: true),

            Note(title: "לצאת ליניב",
                 date: daysAgo(12), folderId: Folder.inbox.id, isCompleted: true),

            Note(title: "Make Claude code analyse the Nerivio iOS app",
                 date: daysAgo(3), folderId: Folder.inbox.id, isCompleted: true),

            Note(title: "When a brain md file is updated – we need to trigger a new build",
                 date: daysAgo(5), folderId: Folder.inbox.id, isCompleted: true),

            Note(title: "Check info texts in common",
                 date: daysAgo(7), folderId: Folder.inbox.id, isCompleted: true),

            // ── Today's recurring / calendar notes ──
            Note(title: "לעשות כניסה במערכת",
                 date: todayAt(8), folderId: Folder.inbox.id,
                 isRecurring: true, hasAlarm: true),

            Note(title: "Lunch Break",
                 date: todayAt(12), folderId: Folder.inbox.id,
                 isCalendarEvent: true, eventRange: "12:00 - 13:00"),

            Note(title: "אוריה - חוג",
                 date: todayAt(17), folderId: Folder.inbox.id,
                 isCalendarEvent: true, eventRange: "17:00 - 18:00"),

            Note(title: "לעשות יציאה במערכת",
                 date: todayAt(18), folderId: Folder.inbox.id,
                 isRecurring: true, hasAlarm: true),

            Note(title: "Visit Reddit",
                 date: .now, folderId: Folder.inbox.id,
                 isRecurring: true),

            // ── Work ──
            Note(title: "Code review sprint 14",
                 body: "SwiftUI memory leak fix",
                 date: daysAgo(2), folderId: Folder.work.id),

            Note(title: "Gamification milestone",
                 body: "Adherence rank card UI",
                 date: daysAgo(4), folderId: Folder.work.id),

            // ── Personal ──
            Note(title: "Book recommendations",
                 body: "Clean Code, SICP, Thinking Fast & Slow",
                 date: daysAgo(9), folderId: Folder.personal.id),
        ]
    }
}
