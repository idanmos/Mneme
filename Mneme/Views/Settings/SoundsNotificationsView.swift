import SwiftUI

struct SoundsNotificationsView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        SettingsPage(title: "Sounds & Notifications".localized) {

            // ── Daily Notification ──
            SettingsSection {
                SettingsNavRow(label: "Daily Notification".localized) {
                    state.settingsPath.append(.dailyNotification)
                }
            }

            // ── Reminder Ringtone ──
            SettingsSection {
                SettingsNavRow(
                    label: "Reminder Ringtone".localized,
                    value: preferences.reminderRingtone.displayName
                ) {
                    state.settingsPath.append(.reminderRingtone)
                }

                Divider().padding(.leading, Spacing.cardPadding)

                SettingsToggleRow(
                    label: "Priority Reminder Ringtone".localized,
                    isOn: $preferences.priorityReminderEnabled,
                    subtitle: "Different ringtones for different priority tasks.".localized
                )

                if preferences.priorityReminderEnabled {
                    Divider().padding(.leading, Spacing.cardPadding)

                    SettingsNavRow(
                        label: "High Priority".localized,
                        value: preferences.highPriorityRingtone.displayName
                    ) {
                        state.settingsPath.append(.priorityRingtone(.high))
                    }

                    Divider().padding(.leading, Spacing.cardPadding)

                    SettingsNavRow(
                        label: "Medium Priority".localized,
                        value: preferences.mediumPriorityRingtone.displayName
                    ) {
                        state.settingsPath.append(.priorityRingtone(.medium))
                    }

                    Divider().padding(.leading, Spacing.cardPadding)

                    SettingsNavRow(
                        label: "Low Priority".localized,
                        value: preferences.lowPriorityRingtone.displayName
                    ) {
                        state.settingsPath.append(.priorityRingtone(.low))
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: preferences.priorityReminderEnabled)

            // ── Constant Reminder ──
            SettingsSection {
                SettingsNavRow(label: "Constant Reminder".localized) {
                    state.settingsPath.append(.constantReminder)
                }
            }

            // ── Email Notifications ──
            SettingsSection {
                SettingsNavRow(
                    label: "Email Notifications".localized,
                    value: preferences.emailNotificationsEnabled ? nil : "Not Enabled".localized
                ) {
                    state.settingsPath.append(.emailNotifications)
                }
            }

            // ── Completion Sound & App Haptics ──
            SettingsSection {
                SettingsNavRow(
                    label: "Completion Sound".localized,
                    value: preferences.completionSound.displayName
                ) {
                    state.settingsPath.append(.completionSound)
                }

                Divider().padding(.leading, Spacing.cardPadding)

                SettingsToggleRow(
                    label: "App Haptics".localized,
                    isOn: $preferences.appHapticsEnabled,
                    subtitle: "There will be a slight vibration when completing or dragging the task.".localized
                )
            }
        }
    }
}
