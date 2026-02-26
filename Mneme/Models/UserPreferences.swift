import Combine
import SwiftUI

// MARK: - Completion Sound

enum CompletionSound: String, CaseIterable, Identifiable {
    case none
    case jingle
    case drip
    case knock
    case spiral

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .none: "None".localized
        case .jingle: "Jingle".localized
        case .drip: "Drip".localized
        case .knock: "Knock".localized
        case .spiral: "Spiral".localized
        }
    }
}

// MARK: - Reminder Ringtone

enum ReminderRingtone: String, CaseIterable, Identifiable {
    case drum
    case beep
    case blocks
    case chimes
    case crystal
    case harp
    case ladder
    case lattice
    case leap
    case matrix
    case musicBox
    case pulse
    case spiral

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .drum: "Drum".localized
        case .beep: "Beep".localized
        case .blocks: "Blocks".localized
        case .chimes: "Chimes".localized
        case .crystal: "Crystal".localized
        case .harp: "Harp".localized
        case .ladder: "Ladder".localized
        case .lattice: "Lattice".localized
        case .leap: "Leap".localized
        case .matrix: "Matrix".localized
        case .musicBox: "Music Box".localized
        case .pulse: "Pulse".localized
        case .spiral: "Spiral".localized
        }
    }
}

// MARK: - Constant Reminder Type

enum ConstantReminderType: String {
    case alarm
    case notification
}

// MARK: - App Badge Count

enum AppBadgeCount: String, CaseIterable, Identifiable {
    case none
    case overdueByTime
    case today
    case overdueByDate
    case todayAndOverdue

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .none: "None".localized
        case .overdueByTime: "Overdue based on time".localized
        case .today: "Today".localized
        case .overdueByDate: "Overdue based on date".localized
        case .todayAndOverdue: "Today & Overdue based on date".localized
        }
    }
}

// MARK: - App Theme

enum AppTheme: String, CaseIterable, Identifiable {
    case `default`
    case teal
    case turquoise
    case matcha
    case sunshine
    case peach
    case lilac
    case pearl
    case pebble
    case dark

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .default: "Default".localized
        case .teal: "Teal".localized
        case .turquoise: "Turquoise".localized
        case .matcha: "Matcha".localized
        case .sunshine: "Sunshine".localized
        case .peach: "Peach".localized
        case .lilac: "Lilac".localized
        case .pearl: "Pearl".localized
        case .pebble: "Pebble".localized
        case .dark: "Dark".localized
        }
    }

    var color: Color {
        switch self {
        case .default: Color(hex: "4F6EFF")
        case .teal: Color(hex: "A8D8DC")
        case .turquoise: Color(hex: "7EC8C8")
        case .matcha: Color(hex: "C5D9A4")
        case .sunshine: Color(hex: "F5D58E")
        case .peach: Color(hex: "F5B5C8")
        case .lilac: Color(hex: "CDB5E8")
        case .pearl: Color(hex: "D8D4CC")
        case .pebble: Color(hex: "8E8E93")
        case .dark: Color(hex: "1C1C1E")
        }
    }

    /// Whether this theme should force dark mode.
    var prefersDarkMode: Bool {
        self == .dark
    }
}

// MARK: - Font Size

enum AppFontSize: String, CaseIterable, Identifiable {
    case systemDefault
    case standard
    case large

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .systemDefault: "System Default".localized
        case .standard: "Standard".localized
        case .large: "Large".localized
        }
    }

    /// Scale factor applied to base font sizes.
    var scale: CGFloat {
        switch self {
        case .systemDefault: 1.0
        case .standard: 1.0
        case .large: 1.15
        }
    }
}

// MARK: - Completed Task Style

enum CompletedTaskStyle: String, CaseIterable, Identifiable {
    case `default`
    case strikethrough

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .default: "Default".localized
        case .strikethrough: "Strikethrough".localized
        }
    }
}

// MARK: - Priority Level

enum PriorityLevel: String, CaseIterable, Identifiable, Hashable {
    case high
    case medium
    case low

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .high: "High Priority".localized
        case .medium: "Medium Priority".localized
        case .low: "Low Priority".localized
        }
    }
}

// MARK: - Settings Tab Item

enum SettingsTabItem: String, CaseIterable, Identifiable, Hashable {
    case task
    case calendar
    case settings
    case eisenhowerMatrix
    case pomodoro
    case habitTracker
    case countdown
    case search

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .task: "Task".localized
        case .calendar: "Calendar".localized
        case .settings: "Settings".localized
        case .eisenhowerMatrix: "Eisenhower Matrix".localized
        case .pomodoro: "Pomodoro".localized
        case .habitTracker: "Habit Tracker".localized
        case .countdown: "Countdown".localized
        case .search: "Search".localized
        }
    }

    var subtitle: String {
        switch self {
        case .task: "Manage your task with lists and filters.".localized
        case .calendar: "Manage your task with five calendar views.".localized
        case .settings: "Make changes to the current settings.".localized
        case .eisenhowerMatrix: "Focus on what's important and urgent.".localized
        case .pomodoro: "Use the Pomo timer or stopwatch to keep focus.".localized
        case .habitTracker: "Develop a habit and keep track of it.".localized
        case .countdown: "Remember every special day.".localized
        case .search: "Do a quick search easily.".localized
        }
    }

    var icon: String {
        switch self {
        case .task: "checkmark.square.fill"
        case .calendar: "calendar"
        case .settings: "gearshape.fill"
        case .eisenhowerMatrix: "square.grid.2x2.fill"
        case .pomodoro: "circle.dotted"
        case .habitTracker: "clock.fill"
        case .countdown: "star.fill"
        case .search: "magnifyingglass"
        }
    }

    var iconColor: Color {
        switch self {
        case .task: .appAccent
        case .calendar: .appAccent
        case .settings: .textSecondary
        case .eisenhowerMatrix: .appAccent
        case .pomodoro: .textPrimary
        case .habitTracker: .appAccent
        case .countdown: .badgeOrange
        case .search: .textSecondary
        }
    }
}

// MARK: - Settings Route

enum SettingsRoute: Hashable {
    case soundsNotifications
    case completionSound
    case reminderRingtone
    case priorityRingtone(PriorityLevel)
    case dailyNotification
    case constantReminder
    case emailNotifications
    case appearance
    case tabBar
}

// MARK: - UserDefaults Keys

private enum PreferenceKey {
    static let completionSound = "pref_completionSound"
    static let reminderRingtone = "pref_reminderRingtone"
    static let priorityReminderEnabled = "pref_priorityReminderEnabled"
    static let highPriorityRingtone = "pref_highPriorityRingtone"
    static let mediumPriorityRingtone = "pref_mediumPriorityRingtone"
    static let lowPriorityRingtone = "pref_lowPriorityRingtone"
    static let appHapticsEnabled = "pref_appHapticsEnabled"

    static let dailyNotificationEnabled = "pref_dailyNotificationEnabled"
    static let notificationTimes = "pref_notificationTimes"
    static let overdueTaskNotification = "pref_overdueTaskNotification"
    static let allDayTaskNotification = "pref_allDayTaskNotification"
    static let weeklyActivationDays = "pref_weeklyActivationDays"

    static let constantReminderType = "pref_constantReminderType"
    static let globalConstantReminder = "pref_globalConstantReminder"

    static let emailNotificationsEnabled = "pref_emailNotificationsEnabled"
    static let emailAddress = "pref_emailAddress"
    static let notificationContentTasks = "pref_notificationContentTasks"
    static let notificationContentHabits = "pref_notificationContentHabits"

    static let appTheme = "pref_appTheme"
    static let autoNightMode = "pref_autoNightMode"
    static let appBadgeCount = "pref_appBadgeCount"
    static let fontSize = "pref_fontSize"
    static let showSidebarCount = "pref_showSidebarCount"
    static let hideNote = "pref_hideNote"
    static let showListColor = "pref_showListColor"
    static let completedTaskStyle = "pref_completedTaskStyle"

    static let enabledTabs = "pref_enabledTabs"
    static let disabledTabs = "pref_disabledTabs"
    static let maxTabs = "pref_maxTabs"
}

// MARK: - User Preferences

final class UserPreferences: ObservableObject {

    private let defaults = UserDefaults.standard
    private var cancellables: Set<AnyCancellable> = []

    // MARK: Sounds & Notifications

    @Published var completionSound: CompletionSound {
        didSet { defaults.set(completionSound.rawValue, forKey: PreferenceKey.completionSound) }
    }
    @Published var reminderRingtone: ReminderRingtone {
        didSet { defaults.set(reminderRingtone.rawValue, forKey: PreferenceKey.reminderRingtone) }
    }
    @Published var priorityReminderEnabled: Bool {
        didSet { defaults.set(priorityReminderEnabled, forKey: PreferenceKey.priorityReminderEnabled) }
    }
    @Published var highPriorityRingtone: ReminderRingtone {
        didSet { defaults.set(highPriorityRingtone.rawValue, forKey: PreferenceKey.highPriorityRingtone) }
    }
    @Published var mediumPriorityRingtone: ReminderRingtone {
        didSet { defaults.set(mediumPriorityRingtone.rawValue, forKey: PreferenceKey.mediumPriorityRingtone) }
    }
    @Published var lowPriorityRingtone: ReminderRingtone {
        didSet { defaults.set(lowPriorityRingtone.rawValue, forKey: PreferenceKey.lowPriorityRingtone) }
    }
    @Published var appHapticsEnabled: Bool {
        didSet { defaults.set(appHapticsEnabled, forKey: PreferenceKey.appHapticsEnabled) }
    }

    // MARK: Daily Notification

    @Published var dailyNotificationEnabled: Bool {
        didSet {
            defaults.set(dailyNotificationEnabled, forKey: PreferenceKey.dailyNotificationEnabled)
            scheduleDailyNotifications()
        }
    }
    @Published var notificationTimes: [Date] {
        didSet {
            let intervals = notificationTimes.map { $0.timeIntervalSince1970 }
            defaults.set(intervals, forKey: PreferenceKey.notificationTimes)
            scheduleDailyNotifications()
        }
    }
    @Published var overdueTaskNotification: Bool {
        didSet {
            defaults.set(overdueTaskNotification, forKey: PreferenceKey.overdueTaskNotification)
            scheduleDailyNotifications()
        }
    }
    @Published var allDayTaskNotification: Bool {
        didSet {
            defaults.set(allDayTaskNotification, forKey: PreferenceKey.allDayTaskNotification)
            scheduleDailyNotifications()
        }
    }
    @Published var weeklyActivationDays: Set<Int> {
        didSet {
            defaults.set(Array(weeklyActivationDays), forKey: PreferenceKey.weeklyActivationDays)
            scheduleDailyNotifications()
        }
    }

    // MARK: Constant Reminder

    @Published var constantReminderType: ConstantReminderType {
        didSet { defaults.set(constantReminderType.rawValue, forKey: PreferenceKey.constantReminderType) }
    }
    @Published var globalConstantReminder: Bool {
        didSet { defaults.set(globalConstantReminder, forKey: PreferenceKey.globalConstantReminder) }
    }

    // MARK: Email Notifications

    @Published var emailNotificationsEnabled: Bool {
        didSet { defaults.set(emailNotificationsEnabled, forKey: PreferenceKey.emailNotificationsEnabled) }
    }
    @Published var emailAddress: String {
        didSet { defaults.set(emailAddress, forKey: PreferenceKey.emailAddress) }
    }
    @Published var notificationContentTasks: Bool {
        didSet { defaults.set(notificationContentTasks, forKey: PreferenceKey.notificationContentTasks) }
    }
    @Published var notificationContentHabits: Bool {
        didSet { defaults.set(notificationContentHabits, forKey: PreferenceKey.notificationContentHabits) }
    }

    // MARK: Appearance

    @Published var appTheme: AppTheme {
        didSet { defaults.set(appTheme.rawValue, forKey: PreferenceKey.appTheme) }
    }
    @Published var autoNightMode: Bool {
        didSet { defaults.set(autoNightMode, forKey: PreferenceKey.autoNightMode) }
    }
    @Published var appBadgeCount: AppBadgeCount {
        didSet { defaults.set(appBadgeCount.rawValue, forKey: PreferenceKey.appBadgeCount) }
    }
    @Published var fontSize: AppFontSize {
        didSet { defaults.set(fontSize.rawValue, forKey: PreferenceKey.fontSize) }
    }
    @Published var showSidebarCount: Bool {
        didSet { defaults.set(showSidebarCount, forKey: PreferenceKey.showSidebarCount) }
    }
    @Published var hideNote: Bool {
        didSet { defaults.set(hideNote, forKey: PreferenceKey.hideNote) }
    }
    @Published var showListColor: Bool {
        didSet { defaults.set(showListColor, forKey: PreferenceKey.showListColor) }
    }
    @Published var completedTaskStyle: CompletedTaskStyle {
        didSet { defaults.set(completedTaskStyle.rawValue, forKey: PreferenceKey.completedTaskStyle) }
    }

    // MARK: Tab Bar

    @Published var enabledTabs: [SettingsTabItem] {
        didSet {
            defaults.set(enabledTabs.map(\.rawValue), forKey: PreferenceKey.enabledTabs)
        }
    }
    @Published var disabledTabs: [SettingsTabItem] {
        didSet {
            defaults.set(disabledTabs.map(\.rawValue), forKey: PreferenceKey.disabledTabs)
        }
    }
    @Published var maxTabs: Int {
        didSet { defaults.set(maxTabs, forKey: PreferenceKey.maxTabs) }
    }

    // MARK: - Computed

    /// Resolved color scheme based on theme and auto-night mode.
    var resolvedColorScheme: ColorScheme? {
        if appTheme.prefersDarkMode { return .dark }
        if autoNightMode { return nil } // follow system
        return .light
    }

    /// Accent color from current theme.
    var accentColor: Color {
        appTheme.color
    }

    // MARK: - Init

    init() {
        let d = UserDefaults.standard

        // Sounds & Notifications
        completionSound = Self.enumValue(d, key: PreferenceKey.completionSound, default: .jingle)
        reminderRingtone = Self.enumValue(d, key: PreferenceKey.reminderRingtone, default: .beep)
        priorityReminderEnabled = d.bool(forKey: PreferenceKey.priorityReminderEnabled)
        highPriorityRingtone = Self.enumValue(d, key: PreferenceKey.highPriorityRingtone, default: .blocks)
        mediumPriorityRingtone = Self.enumValue(d, key: PreferenceKey.mediumPriorityRingtone, default: .harp)
        lowPriorityRingtone = Self.enumValue(d, key: PreferenceKey.lowPriorityRingtone, default: .musicBox)
        appHapticsEnabled = d.object(forKey: PreferenceKey.appHapticsEnabled) as? Bool ?? true

        // Daily Notification
        dailyNotificationEnabled = d.object(forKey: PreferenceKey.dailyNotificationEnabled) as? Bool ?? true

        if let intervals = d.array(forKey: PreferenceKey.notificationTimes) as? [TimeInterval] {
            notificationTimes = intervals.map { Date(timeIntervalSince1970: $0) }
        } else {
            let calendar = Calendar.current
            notificationTimes = [calendar.date(from: DateComponents(hour: 9, minute: 0)) ?? Date()]
        }

        overdueTaskNotification = d.object(forKey: PreferenceKey.overdueTaskNotification) as? Bool ?? true
        allDayTaskNotification = d.object(forKey: PreferenceKey.allDayTaskNotification) as? Bool ?? true

        if let days = d.array(forKey: PreferenceKey.weeklyActivationDays) as? [Int] {
            weeklyActivationDays = Set(days)
        } else {
            weeklyActivationDays = [0, 1, 2, 3, 4]
        }

        // Constant Reminder
        constantReminderType = Self.enumValue(d, key: PreferenceKey.constantReminderType, default: .notification)
        globalConstantReminder = d.bool(forKey: PreferenceKey.globalConstantReminder)

        // Email Notifications
        emailNotificationsEnabled = d.bool(forKey: PreferenceKey.emailNotificationsEnabled)
        emailAddress = d.string(forKey: PreferenceKey.emailAddress) ?? ""
        notificationContentTasks = d.object(forKey: PreferenceKey.notificationContentTasks) as? Bool ?? true
        notificationContentHabits = d.object(forKey: PreferenceKey.notificationContentHabits) as? Bool ?? true

        // Appearance
        appTheme = Self.enumValue(d, key: PreferenceKey.appTheme, default: .default)
        autoNightMode = d.object(forKey: PreferenceKey.autoNightMode) as? Bool ?? true
        appBadgeCount = Self.enumValue(d, key: PreferenceKey.appBadgeCount, default: .today)
        fontSize = Self.enumValue(d, key: PreferenceKey.fontSize, default: .systemDefault)
        showSidebarCount = d.object(forKey: PreferenceKey.showSidebarCount) as? Bool ?? true
        hideNote = d.bool(forKey: PreferenceKey.hideNote)
        showListColor = d.object(forKey: PreferenceKey.showListColor) as? Bool ?? true
        completedTaskStyle = Self.enumValue(d, key: PreferenceKey.completedTaskStyle, default: .default)

        // Tab Bar
        if let rawTabs = d.array(forKey: PreferenceKey.enabledTabs) as? [String] {
            enabledTabs = rawTabs.compactMap { SettingsTabItem(rawValue: $0) }
        } else {
            enabledTabs = [.task, .calendar, .settings]
        }

        if let rawDisabled = d.array(forKey: PreferenceKey.disabledTabs) as? [String] {
            disabledTabs = rawDisabled.compactMap { SettingsTabItem(rawValue: $0) }
        } else {
            disabledTabs = [.eisenhowerMatrix, .pomodoro, .habitTracker, .countdown, .search]
        }

        maxTabs = d.object(forKey: PreferenceKey.maxTabs) as? Int ?? 5
    }

    // MARK: - Helpers

    func ringtone(for priority: PriorityLevel) -> ReminderRingtone {
        switch priority {
        case .high: highPriorityRingtone
        case .medium: mediumPriorityRingtone
        case .low: lowPriorityRingtone
        }
    }

    func setRingtone(_ ringtone: ReminderRingtone, for priority: PriorityLevel) {
        switch priority {
        case .high: highPriorityRingtone = ringtone
        case .medium: mediumPriorityRingtone = ringtone
        case .low: lowPriorityRingtone = ringtone
        }
    }

    /// Trigger haptic feedback if haptics are enabled.
    func hapticIfEnabled(_ style: HapticStyle = .medium) {
        guard appHapticsEnabled else { return }
        switch style {
        case .light: HapticManager.shared.lightImpact()
        case .medium: HapticManager.shared.mediumImpact()
        case .success: HapticManager.shared.success()
        case .selection: HapticManager.shared.selectionChanged()
        }
    }

    enum HapticStyle {
        case light, medium, success, selection
    }

    // MARK: - Notification Scheduling

    private func scheduleDailyNotifications() {
        NotificationManager.shared.scheduleDailyNotifications(
            times: notificationTimes,
            weekdays: weeklyActivationDays,
            overdueEnabled: overdueTaskNotification,
            allDayEnabled: allDayTaskNotification,
            enabled: dailyNotificationEnabled
        )
    }

    // MARK: - Private Helpers

    private static func enumValue<T: RawRepresentable>(
        _ defaults: UserDefaults,
        key: String,
        default defaultValue: T
    ) -> T where T.RawValue == String {
        guard let raw = defaults.string(forKey: key),
              let value = T(rawValue: raw)
        else { return defaultValue }
        return value
    }
}
