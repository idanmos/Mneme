import UserNotifications

final class NotificationManager {

    static let shared = NotificationManager()

    private init() {}

    // MARK: - Permission

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error {
                print("Notification permission error: \(error)")
            }
            print("Notification permission granted: \(granted)")
        }
    }

    // MARK: - Daily Notifications

    /// Schedule daily notifications at the given times on the given weekdays.
    func scheduleDailyNotifications(
        times: [Date],
        weekdays: Set<Int>,
        overdueEnabled: Bool,
        allDayEnabled: Bool,
        enabled: Bool
    ) {
        let center = UNUserNotificationCenter.current()

        // Remove existing daily notifications
        center.removePendingNotificationRequests(withIdentifiers: dailyNotificationIDs())

        guard enabled, !times.isEmpty, !weekdays.isEmpty else { return }

        let calendar = Calendar.current

        for (timeIndex, time) in times.enumerated() {
            let hour = calendar.component(.hour, from: time)
            let minute = calendar.component(.minute, from: time)

            // Map our 0-indexed weekdays (Sun=0) to Calendar weekday (Sun=1)
            for day in weekdays {
                let calendarWeekday = day + 1

                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minute
                dateComponents.weekday = calendarWeekday

                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                let content = UNMutableNotificationContent()
                content.title = "Daily Overview".localized
                content.body = dailyNotificationBody(overdueEnabled: overdueEnabled, allDayEnabled: allDayEnabled)
                content.sound = .default

                let id = "daily_\(timeIndex)_\(day)"
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

                center.add(request) { error in
                    if let error {
                        print("Failed to schedule notification: \(error)")
                    }
                }
            }
        }
    }

    // MARK: - Badge

    func updateBadge(count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count) { error in
            if let error {
                print("Failed to set badge count: \(error)")
            }
        }
    }

    func clearBadge() {
        updateBadge(count: 0)
    }

    // MARK: - Private

    private func dailyNotificationIDs() -> [String] {
        var ids: [String] = []
        for timeIndex in 0..<10 {
            for day in 0..<7 {
                ids.append("daily_\(timeIndex)_\(day)")
            }
        }
        return ids
    }

    private func dailyNotificationBody(overdueEnabled: Bool, allDayEnabled: Bool) -> String {
        var parts: [String] = []
        if overdueEnabled { parts.append("Overdue tasks".localized) }
        if allDayEnabled { parts.append("All-day tasks".localized) }
        if parts.isEmpty {
            return "Check your tasks for today.".localized
        }
        return "You have ".localized + parts.joined(separator: " & ".localized) + " today.".localized
    }
}

