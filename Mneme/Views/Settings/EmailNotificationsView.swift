import SwiftUI

struct EmailNotificationsView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences
    @State private var showContentPicker = false
    @FocusState private var emailFieldFocused: Bool

    var body: some View {
        SettingsPage(title: "Email Notifications".localized) {

            // ── Illustration ──
            emailIllustration

            // ── Toggle + details ──
            SettingsSection {
                SettingsToggleRow(
                    label: "Email Notifications".localized,
                    isOn: $preferences.emailNotificationsEnabled,
                    subtitle: "If enabled, you can receive task notifications in Emails. The daily limit of reminders is 50.".localized,
                    isPremium: true
                )

                if preferences.emailNotificationsEnabled {
                    Divider().padding(.leading, Spacing.cardPadding)

                    // Editable email field
                    HStack {
                        Text("Email".localized)
                            .font(.mnemeBody)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        TextField("email@example.com", text: $preferences.emailAddress)
                            .font(.system(size: 14))
                            .foregroundColor(.textPrimary)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .focused($emailFieldFocused)
                    }
                    .padding(.horizontal, Spacing.cardPadding)
                    .padding(.vertical, 14)
                }
            }

            // ── Notification Content ──
            if preferences.emailNotificationsEnabled {
                SettingsSection {
                    Button {
                        withAnimation { showContentPicker.toggle() }
                    } label: {
                        HStack {
                            Text("Notification Content".localized)
                                .font(.mnemeBody)
                                .foregroundColor(.textPrimary)

                            Spacer()

                            Text(notificationContentSummary)
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)

                            Image(systemName: "chevron.up.chevron.down")
                                .font(.system(size: 11))
                                .foregroundColor(.textSecondary)
                        }
                        .padding(.horizontal, Spacing.cardPadding)
                        .padding(.vertical, 14)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }

                // ── Content picker dropdown ──
                if showContentPicker {
                    VStack(spacing: 0) {
                        SettingsCheckboxRow(
                            label: "Tasks".localized,
                            isSelected: preferences.notificationContentTasks
                        ) {
                            preferences.notificationContentTasks.toggle()
                        }

                        Divider().padding(.leading, Spacing.cardPadding)

                        SettingsCheckboxRow(
                            label: "Habits".localized,
                            isSelected: preferences.notificationContentHabits
                        ) {
                            preferences.notificationContentHabits.toggle()
                        }
                    }
                    .background(Color.cardBackground)
                    .cornerRadius(Radius.card)
                    .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
                    .padding(.top, -8)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: preferences.emailNotificationsEnabled)
    }

    private var notificationContentSummary: String {
        var parts: [String] = []
        if preferences.notificationContentTasks { parts.append("Tasks".localized) }
        if preferences.notificationContentHabits { parts.append("Habits".localized) }
        return parts.joined(separator: ", ")
    }

    // MARK: - Illustration

    private var emailIllustration: some View {
        ZStack {
            // Task list card
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<2, id: \.self) { _ in
                    HStack(spacing: 8) {
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.textSecondary.opacity(0.3), lineWidth: 1.5)
                            .frame(width: 14, height: 14)
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.textSecondary.opacity(0.2))
                            .frame(width: 80, height: 8)
                    }
                }
            }
            .padding(16)
            .background(Color(hex: "E8ECF8"))
            .cornerRadius(12)

            // Email icon
            ZStack {
                Circle()
                    .fill(Color.appAccent)
                    .frame(width: 56, height: 56)
                Image(systemName: "envelope.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
            }
            .offset(x: -90, y: -30)

            // Checkmark icon
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 48, height: 48)
                    .shadow(color: .black.opacity(0.08), radius: 4)
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.appAccent)
            }
            .offset(x: 90, y: 20)

            // Decorative sparkles
            Image(systemName: "sparkle")
                .font(.system(size: 14))
                .foregroundColor(.badgeOrange)
                .offset(x: -70, y: 40)

            Image(systemName: "sparkle")
                .font(.system(size: 10))
                .foregroundColor(.badgeOrange)
                .offset(x: 60, y: -50)
        }
        .frame(height: 180)
    }
}
