import SwiftUI

struct Folder: Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var sfSymbol: String
    var iconColor: Color = .white
    var badgeColor: Color = Color(hex: "1C2B5E")   // sidebar bg — invisible default
    var count: Int? = nil
    var hasDisclosureArrow: Bool = false
    var isSpecial: Bool = false   // "Today" gets a custom calendar icon

    // MARK: - Defaults (stable IDs so references survive app restarts)

    static var today = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        name: "Today",
        sfSymbol: "calendar",
        iconColor: .white,
        count: 7,
        isSpecial: true
    )

    static var inbox = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
        name: "Inbox",
        sfSymbol: "archivebox.fill",
        iconColor: .white
    )

    static var subscribedCalendars = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
        name: "Subscribed Calendars",
        sfSymbol: "dot.radiowaves.right",
        iconColor: .orange,
        count: 115,
        hasDisclosureArrow: true
    )

    static var car = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
        name: "Car",
        sfSymbol: "car.fill",
        iconColor: Color(hex: "FF3B30"),
        count: 2
    )

    static var reminders = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
        name: "תזכורות",
        sfSymbol: "line.3.horizontal",
        iconColor: .white
    )

    static var work = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
        name: "Work",
        sfSymbol: "briefcase.fill",
        iconColor: .white,
        count: 8
    )

    static var personal = Folder(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
        name: "Personal",
        sfSymbol: "house.fill",
        iconColor: .white,
        count: 7
    )

    static var defaultFolders: [Folder] {
        [.today, .inbox, .subscribedCalendars, .car, .reminders, .work, .personal]
    }
}
