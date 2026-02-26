import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        NavigationStack(path: $state.settingsPath) {
            settingsMainContent
                .toolbar(.hidden, for: .navigationBar)
                .navigationDestination(for: SettingsRoute.self) { route in
                    settingsDestination(for: route)
                        .toolbar(.hidden, for: .navigationBar)
                        .environmentObject(state)
                        .environmentObject(preferences)
                }
        }
    }

    // MARK: - Main Content

    private var settingsMainContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                // ── Title ──
                Text("Settings".localized)
                    .font(.mnemeNavTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 60)
                    .padding(.bottom, 4)

                // ── Profile card ──
                ProfileCardView()

                // ── Tab bar ──
                SettingsCard(items: [
                    SettingsItem(
                        icon: "rectangle.grid.2x2.fill",
                        label: "Tab Bar".localized,
                        iconBg: Color(hex: "635BFF")
                    ),
                ]) { _ in
                    state.settingsPath.append(.tabBar)
                }

                // ── Preferences ──
                SettingsCard(items: [
                    SettingsItem(icon: "paintbrush.fill",        label: "Appearance".localized,             iconBg: Color(hex: "007AFF")),
                    SettingsItem(icon: "music.note",             label: "Sounds & Notifications".localized, iconBg: Color(hex: "34C759")),
                    SettingsItem(icon: "clock.fill",             label: "Date & Time".localized,            iconBg: Color(hex: "FF9F0A")),
                    SettingsItem(icon: "rectangle.3.group.fill", label: "Widgets".localized,                iconBg: Color(hex: "5856D6")),
                    SettingsItem(icon: "list.bullet.indent",     label: "General".localized,                iconBg: Color(hex: "636366")),
                ]) { index in
                    switch index {
                    case 0: state.settingsPath.append(.appearance)
                    case 1: state.settingsPath.append(.soundsNotifications)
                    default: break
                    }
                }

                // ── Integrations ──
                SettingsCard(items: [
                    SettingsItem(
                        icon: "arrow.right.circle.fill",
                        label: "Import & Integration".localized,
                        iconBg: Color(hex: "30B0C7"),
                        trailingType: .integrationIcons
                    ),
                ])

                // ── Help ──
                SettingsCard(items: [
                    SettingsItem(icon: "star.circle.fill",  label: "Help & Feedback".localized, iconBg: Color(hex: "FF9500")),
                    SettingsItem(icon: "person.2.fill",     label: "Follow Us".localized,       iconBg: Color(hex: "007AFF"), trailingType: .socialIcons),
                    SettingsItem(icon: "info.circle.fill",  label: "About".localized,           iconBg: Color(hex: "8E8E93"), trailingType: .text("v8.0.20")),
                ])

                // ── Sign out ──
                Button("Sign Out".localized) {}
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.cardBackground)
                    .cornerRadius(Radius.card)

                Spacer().frame(height: 100)
            }
            .padding(.horizontal, Spacing.screenHorizontal)
        }
    }

    // MARK: - Navigation Destinations

    @ViewBuilder
    private func settingsDestination(for route: SettingsRoute) -> some View {
        switch route {
        case .soundsNotifications:
            SoundsNotificationsView()
        case .completionSound:
            CompletionSoundView()
        case .reminderRingtone:
            ReminderRingtoneView()
        case .priorityRingtone(let level):
            ReminderRingtoneView(priorityLevel: level)
        case .dailyNotification:
            DailyNotificationView()
        case .constantReminder:
            ConstantReminderView()
        case .emailNotifications:
            EmailNotificationsView()
        case .appearance:
            AppearanceView()
        case .tabBar:
            TabBarSettingsView()
        }
    }
}
