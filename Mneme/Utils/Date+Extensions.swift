import Foundation

extension Date {

    // MARK: - Helpers

    static func daysAgo(_ n: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -n, to: .now) ?? .now
    }

    static func today(at hour: Int, minute: Int = 0) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: .now) ?? .now
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    // MARK: - Formatted strings

    /// "d MMM" — used on note row right label
    var shortLabel: String {
        let f = DateFormatter()
        f.dateFormat = "d MMM"
        return f.string(from: self)
    }

    /// "HH:mm"
    var timeLabel: String {
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        return f.string(from: self)
    }

    /// "MMMM" — calendar screen header
    var monthName: String {
        let f = DateFormatter()
        f.dateFormat = "MMMM"
        return f.string(from: self)
    }

    /// "EEE d MMM" — calendar day section header
    var dayHeaderLabel: String {
        let f = DateFormatter()
        f.dateFormat = "EEE d MMM"
        return f.string(from: self).uppercased()
    }

    // MARK: - Calendar helpers

    var dayNumber: Int {
        Calendar.current.component(.day, from: self)
    }

    /// First day of the current month, used by MonthGridView
    var firstDayOfMonth: Date {
        let cal = Calendar.current
        let components = cal.dateComponents([.year, .month], from: self)
        return cal.date(from: components) ?? self
    }

    /// Number of days in the month
    var daysInMonth: Int {
        Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 30
    }

    /// Weekday index (0 = Sunday) of the first day of the month
    var firstWeekdayOfMonth: Int {
        Calendar.current.component(.weekday, from: firstDayOfMonth) - 1
    }

    /// Offset this date by `months` months
    func addingMonths(_ months: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: months, to: self) ?? self
    }
}
