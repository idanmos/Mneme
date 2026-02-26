import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                // ── Title ──
                Text("Settings")
                    .font(.mnemeNavTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 60)
                    .padding(.bottom, 4)

                // ── Profile card ──
                ProfileCardView()

                // ── Tab bar ──
                SettingsCard(items: [
                    SettingsItem(icon: "rectangle.grid.2x2.fill",  label: "Tab Bar",      iconBg: Color(hex: "635BFF")),
                ])

                // ── Preferences ──
                SettingsCard(items: [
                    SettingsItem(icon: "paintbrush.fill",       label: "Appearance",             iconBg: Color(hex: "007AFF")),
                    SettingsItem(icon: "music.note",            label: "Sounds & Notifications", iconBg: Color(hex: "34C759")),
                    SettingsItem(icon: "clock.fill",            label: "Date & Time",            iconBg: Color(hex: "FF9F0A")),
                    SettingsItem(icon: "rectangle.3.group.fill",label: "Widgets",                iconBg: Color(hex: "5856D6")),
                    SettingsItem(icon: "list.bullet.indent",    label: "General",                iconBg: Color(hex: "636366")),
                ])

                // ── Integrations ──
                SettingsCard(items: [
                    SettingsItem(icon: "arrow.right.circle.fill", label: "Import & Integration", iconBg: Color(hex: "30B0C7"), trailingType: .integrationIcons),
                ])

                // ── Help ──
                SettingsCard(items: [
                    SettingsItem(icon: "star.circle.fill",   label: "Help & Feedback", iconBg: Color(hex: "FF9500")),
                    SettingsItem(icon: "person.2.fill",      label: "Follow Us",       iconBg: Color(hex: "007AFF"), trailingType: .socialIcons),
                    SettingsItem(icon: "info.circle.fill",   label: "About",           iconBg: Color(hex: "8E8E93"), trailingType: .text("v8.0.20")),
                ])

                // ── Sign out ──
                Button("Sign Out") {}
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
}
