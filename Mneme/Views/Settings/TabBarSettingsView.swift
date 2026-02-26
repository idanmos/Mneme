import SwiftUI

struct TabBarSettingsView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences
    @State private var showMaxTabsPicker = false

    var body: some View {
        SettingsPage(title: "Tab Bar".localized) {

            // ── Enabled tabs ──
            SettingsSection {
                ForEach(Array(preferences.enabledTabs.enumerated()), id: \.element.id) { index, tab in
                    if index > 0 {
                        Divider().padding(.leading, 52)
                    }

                    tabRow(tab: tab, isEnabled: true)
                }
            }

            // ── Disabled section header ──
            SettingsSectionHeader(title: "Disabled".localized)

            // ── Disabled tabs ──
            SettingsSection {
                if preferences.disabledTabs.isEmpty {
                    Text("All tabs are enabled.".localized)
                        .font(.mnemeCaption)
                        .foregroundColor(.textSecondary)
                        .padding(.horizontal, Spacing.cardPadding)
                        .padding(.vertical, 14)
                } else {
                    ForEach(Array(preferences.disabledTabs.enumerated()), id: \.element.id) { index, tab in
                        if index > 0 {
                            Divider().padding(.leading, 52)
                        }

                        tabRow(tab: tab, isEnabled: false)
                    }
                }
            }

            // ── Max number of tabs ──
            SettingsSection {
                SettingsNavRow(
                    label: "Max number of tabs".localized,
                    value: "\(preferences.maxTabs)"
                ) {
                    showMaxTabsPicker = true
                }
            }

            Text("Over-limited tabs will be shown in More.".localized)
                .font(.mnemeCaption)
                .foregroundColor(.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)

            // ── Tab bar preview ──
            tabBarPreview
        }
        .sheet(isPresented: $showMaxTabsPicker) {
            maxTabsPickerSheet
                .presentationDetents([.height(320)])
                .presentationDragIndicator(.visible)
        }
    }

    // MARK: - Tab Row

    private func tabRow(tab: SettingsTabItem, isEnabled: Bool) -> some View {
        HStack(spacing: 12) {
            // Add/Remove button
            Button {
                toggleTab(tab, isEnabled: isEnabled)
            } label: {
                ZStack {
                    Circle()
                        .fill(isEnabled ? Color.red.opacity(0.15) : Color.appAccent.opacity(0.15))
                        .frame(width: 24, height: 24)

                    Image(systemName: isEnabled ? "minus" : "plus")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(isEnabled ? .red : .appAccent)
                }
            }
            .buttonStyle(.plain)

            // Icon
            Image(systemName: tab.icon)
                .font(.system(size: 18))
                .foregroundColor(tab.iconColor)
                .frame(width: 28)

            // Text
            VStack(alignment: .leading, spacing: 2) {
                Text(tab.displayName)
                    .font(.mnemeBody)
                    .foregroundColor(.textPrimary)

                Text(tab.subtitle)
                    .font(.mnemeCaption)
                    .foregroundColor(.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            // Drag handle
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 14))
                .foregroundColor(.textSecondary.opacity(0.5))
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, 12)
    }

    // MARK: - Toggle Tab

    private func toggleTab(_ tab: SettingsTabItem, isEnabled: Bool) {
        withAnimation(.easeInOut(duration: 0.25)) {
            if isEnabled {
                // Don't allow removing the last tab
                guard preferences.enabledTabs.count > 1 else { return }
                preferences.enabledTabs.removeAll { $0 == tab }
                preferences.disabledTabs.append(tab)
            } else {
                guard preferences.enabledTabs.count < preferences.maxTabs else { return }
                preferences.disabledTabs.removeAll { $0 == tab }
                preferences.enabledTabs.append(tab)
            }
            preferences.hapticIfEnabled(.selection)
        }
    }

    // MARK: - Max Tabs Picker

    private var maxTabsPickerSheet: some View {
        VStack(spacing: 16) {
            Text("Max number of tabs".localized)
                .font(.mnemeNavTitle)
                .padding(.top, 20)

            VStack(spacing: 0) {
                ForEach(3...5, id: \.self) { count in
                    if count > 3 {
                        Divider().padding(.leading, 52)
                    }

                    SettingsRadioRow(
                        label: "\(count)",
                        isSelected: preferences.maxTabs == count
                    ) {
                        preferences.maxTabs = count
                        // Trim enabled tabs if over the new max
                        if preferences.enabledTabs.count > count {
                            let overflow = preferences.enabledTabs.suffix(from: count)
                            preferences.disabledTabs.append(contentsOf: overflow)
                            preferences.enabledTabs = Array(preferences.enabledTabs.prefix(count))
                        }
                        preferences.hapticIfEnabled(.light)
                        showMaxTabsPicker = false
                    }
                }
            }
            .background(Color.cardBackground)
            .cornerRadius(Radius.card)
            .padding(.horizontal, Spacing.screenHorizontal)

            Spacer()
        }
    }

    // MARK: - Tab Bar Preview

    private var tabBarPreview: some View {
        HStack(spacing: 0) {
            ForEach(preferences.enabledTabs) { tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 20))
                    Text(tab.displayName)
                        .font(.system(size: 10))
                }
                .foregroundColor(.textSecondary)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 10)
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
    }
}
