import SwiftUI

struct ConstantReminderView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        SettingsPage(title: "Constant Reminder".localized) {

            // ── Notification preview ──
            notificationPreview

            // ── Reminder type selection ──
            SettingsSection {
                SettingsRadioRow(
                    label: "Alarm Reminder".localized,
                    isSelected: preferences.constantReminderType == .alarm,
                    subtitle: "Works like the system alarm, ringing even in Silent or Sleep mode.".localized
                ) {
                    preferences.constantReminderType = .alarm
                }

                Divider().padding(.leading, 52)

                SettingsRadioRow(
                    label: "Notification Reminder".localized,
                    isSelected: preferences.constantReminderType == .notification,
                    subtitle: "Keep reminding you with repeated notifications. No sound in Silent or Sleep mode.".localized
                ) {
                    preferences.constantReminderType = .notification
                }
            }

            // ── Global Constant Reminder ──
            SettingsSection {
                SettingsToggleRow(
                    label: "Global Constant Reminder".localized,
                    isOn: $preferences.globalConstantReminder,
                    subtitle: "If enabled, all tasks will be constantly reminded until you handle them.".localized
                )
            }
        }
    }

    // MARK: - Notification Preview

    private var notificationPreview: some View {
        VStack(spacing: 0) {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(hex: "B8D4E8"), Color(hex: "D6E4F0")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                VStack(spacing: 12) {
                    // Fake status bar
                    HStack {
                        Text("9:41")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        HStack(spacing: 5) {
                            Image(systemName: "cellularbars")
                            Image(systemName: "wifi")
                            Image(systemName: "battery.100")
                        }
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 14)

                    // Notification banner
                    HStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.white)
                                .frame(width: 36, height: 36)
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.appAccent)
                        }

                        Text("Work Report".localized)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.black)

                        Spacer()

                        Text("Now".localized)
                            .font(.system(size: 12))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(14)
                    .padding(.horizontal, 8)

                    Spacer()
                }
            }
            .frame(height: 180)
        }
        .cornerRadius(Radius.card)
        .clipped()
    }
}
