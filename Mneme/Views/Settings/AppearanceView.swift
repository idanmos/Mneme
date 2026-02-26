import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences
    @State private var selectedTab: Int = 0

    private let tabs = ["Theme", "App Icons", "Display"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {

                // ── Header with segmented tabs ──
                ZStack {
                    HStack {
                        RoundButton(icon: "chevron.left") {
                            state.settingsPath.removeLast()
                        }
                        Spacer()
                    }

                    // Segmented control
                    HStack(spacing: 0) {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    selectedTab = index
                                }
                            } label: {
                                Text(tabs[index].localized)
                                    .font(.system(
                                        size: 14,
                                        weight: selectedTab == index ? .semibold : .regular
                                    ))
                                    .foregroundColor(
                                        selectedTab == index ? .textPrimary : .textSecondary
                                    )
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedTab == index
                                            ? Color.cardBackground
                                            : Color.clear
                                    )
                                    .cornerRadius(20)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(3)
                    .background(Color.appBackground.opacity(0.8))
                    .cornerRadius(22)
                }
                .padding(.horizontal, Spacing.screenHorizontal)
                .padding(.top, 60)
                .padding(.bottom, 4)

                // ── Tab content ──
                Group {
                    switch selectedTab {
                    case 0: themeContent
                    case 1: appIconsContent
                    default: displayContent
                    }
                }
                .padding(.horizontal, Spacing.screenHorizontal)

                Spacer().frame(height: 100)
            }
        }
        .background(Color.appBackground.ignoresSafeArea())
    }

    // MARK: - Theme Tab

    private var themeContent: some View {
        VStack(spacing: 16) {

            // Auto-Night Mode
            SettingsSection {
                SettingsNavRow(
                    label: "Auto-Night Mode".localized,
                    value: preferences.autoNightMode ? "On".localized : "Off".localized
                ) {
                    preferences.autoNightMode.toggle()
                }
            }

            // Color Series
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Color Series".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4),
                        spacing: 12
                    ) {
                        ForEach(AppTheme.allCases) { theme in
                            themeColorCell(theme)
                        }
                    }
                }
                .padding(Spacing.cardPadding)
            }

            // Season Series
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Season Series".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ],
                        spacing: 12
                    ) {
                        seasonCell("Spring".localized, Color(hex: "C8E6C9"))
                        seasonCell("Summer".localized, Color(hex: "B3E5FC"))
                        seasonCell("Autumn".localized, Color(hex: "FFE0B2"))
                        seasonCell("Winter".localized, Color(hex: "E1E5EA"))
                    }
                }
                .padding(Spacing.cardPadding)
            }

            // City Series
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("City Series".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    let cities: [(String, Color)] = [
                        ("Cairo".localized, Color(hex: "E8A87C")),
                        ("London".localized, Color(hex: "C5B3D1")),
                        ("Los Angeles".localized, Color(hex: "7B68AE")),
                        ("Moscow".localized, Color(hex: "8B9DC3")),
                        ("New York".localized, Color(hex: "F5C6AA")),
                        ("San Francisco".localized, Color(hex: "F5B79A")),
                        ("Seoul".localized, Color(hex: "B8D8D8")),
                        ("Shanghai".localized, Color(hex: "2D3561")),
                        ("Sydney".localized, Color(hex: "1B2838")),
                        ("Tokyo".localized, Color(hex: "F5B7C5")),
                    ]

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ],
                        spacing: 12
                    ) {
                        ForEach(cities, id: \.0) { name, color in
                            VStack(spacing: 6) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(
                                        LinearGradient(
                                            colors: [color, color.opacity(0.7)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .aspectRatio(1.6, contentMode: .fit)

                                HStack(spacing: 4) {
                                    Text(name)
                                        .font(.system(size: 11))
                                        .foregroundColor(.textSecondary)
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: 9))
                                        .foregroundColor(.badgeOrange)
                                }
                            }
                        }
                    }
                }
                .padding(Spacing.cardPadding)
            }
        }
    }

    // MARK: - App Icons Tab

    private var appIconsContent: some View {
        VStack(spacing: 16) {

            // App Icons grid
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("App Icons".localized)
                            .font(.mnemeBody)
                            .fontWeight(.semibold)

                        Spacer()

                        HStack(spacing: 4) {
                            Text("View All".localized)
                                .font(.mnemeCaption)
                                .foregroundColor(.textSecondary)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 10))
                                .foregroundColor(.textSecondary)
                        }
                    }

                    let iconColors: [Color] = [
                        Color(hex: "E8EDF8"), Color(hex: "D8E4F8"),
                        Color(hex: "FFF3E0"), Color(hex: "C5CAE9"),
                        Color(hex: "2D2D2D"), Color(hex: "3D2D5D"),
                        Color(hex: "404040"), Color(hex: "1A237E"),
                        Color(hex: "C8E6C9"), Color(hex: "4FC3F7"),
                        Color(hex: "81D4FA"), Color(hex: "E8B4B8"),
                        Color(hex: "F8E4B8"), Color(hex: "90CAF9"),
                        Color(hex: "B2EBF2"), Color(hex: "F48FB1"),
                    ]

                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4),
                        spacing: 10
                    ) {
                        ForEach(0..<iconColors.count, id: \.self) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(iconColors[index])
                                    .aspectRatio(1, contentMode: .fit)

                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .overlay(alignment: .topTrailing) {
                                if index == 8 {
                                    SelectionBadge()
                                        .offset(x: 4, y: -4)
                                } else if index >= 4 {
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(.badgeOrange)
                                        .offset(x: -4, y: 4)
                                }
                            }
                        }
                    }
                }
                .padding(Spacing.cardPadding)
            }

            // App Badge Count
            SettingsSection {
                VStack(alignment: .leading, spacing: 4) {
                    Text("App Badge Count".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    Text("Please choose the type of tasks to have the number shown on the app icon.".localized)
                        .font(.mnemeCaption)
                        .foregroundColor(.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    // Badge preview
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(hex: "C8E6C9"))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.green)
                            )

                        ZStack {
                            Circle().fill(.red).frame(width: 22, height: 22)
                            Text("9")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .offset(x: 6, y: -6)
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, Spacing.cardPadding)
                .padding(.top, 14)

                ForEach(AppBadgeCount.allCases) { badge in
                    Divider().padding(.leading, 52)

                    SettingsRadioRow(
                        label: badge.displayName,
                        isSelected: preferences.appBadgeCount == badge
                    ) {
                        preferences.appBadgeCount = badge
                    }
                }
            }
        }
    }

    // MARK: - Display Tab

    private var displayContent: some View {
        VStack(spacing: 16) {

            // Font Size
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Font Size".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    HStack(spacing: 12) {
                        fontSizeOption(.systemDefault)
                        fontSizeOption(.standard)
                    }

                    HStack(spacing: 12) {
                        fontSizeOption(.large)
                        Color.clear.frame(maxWidth: .infinity)
                    }
                }
                .padding(Spacing.cardPadding)
            }

            // Sidebar Count
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Sidebar Count".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    HStack(spacing: 12) {
                        sidebarCountOption(show: true)
                        sidebarCountOption(show: false)
                    }

                    Divider()

                    SettingsToggleRow(
                        label: "Hide Note".localized,
                        isOn: $preferences.hideNote
                    )
                    .padding(.horizontal, -Spacing.cardPadding)
                }
                .padding(Spacing.cardPadding)
            }

            // List Color
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("List Color".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    HStack(spacing: 12) {
                        listColorOption(show: true)
                        listColorOption(show: false)
                    }
                }
                .padding(Spacing.cardPadding)

                Text("Show or hide list colors in the task list.".localized)
                    .font(.mnemeCaption)
                    .foregroundColor(.textSecondary)
                    .padding(.horizontal, Spacing.cardPadding)
                    .padding(.bottom, 14)
            }

            // Completed Task Style
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Completed Task Style".localized)
                        .font(.mnemeBody)
                        .fontWeight(.semibold)

                    HStack(spacing: 12) {
                        completedStyleOption(.default)
                        completedStyleOption(.strikethrough)
                    }
                }
                .padding(Spacing.cardPadding)
            }
        }
    }

    // MARK: - Helper Views

    private func themeColorCell(_ theme: AppTheme) -> some View {
        Button {
            preferences.appTheme = theme
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            LinearGradient(
                                colors: [theme.color, theme.color.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .aspectRatio(1, contentMode: .fit)

                    if preferences.appTheme == theme {
                        SelectionBadge()
                            .offset(x: 4, y: -4)
                    }
                }

                Text(theme.displayName)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.plain)
    }

    private func seasonCell(_ name: String, _ color: Color) -> some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [color, color.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(1.6, contentMode: .fit)

            HStack(spacing: 4) {
                Text(name)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
                Image(systemName: "crown.fill")
                    .font(.system(size: 9))
                    .foregroundColor(.badgeOrange)
            }
        }
    }

    private func fontSizeOption(_ size: AppFontSize) -> some View {
        Button {
            preferences.fontSize = size
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    Text("Font Size".localized)
                        .font(.system(
                            size: size == .large ? 16 : 14,
                            weight: .medium
                        ))
                        .foregroundColor(.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.appBackground)
                        .cornerRadius(12)

                    if preferences.fontSize == size {
                        SelectionBadge()
                            .offset(x: 4, y: -4)
                    }
                }

                Text(size.displayName)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
        .buttonStyle(.plain)
    }

    private func sidebarCountOption(show: Bool) -> some View {
        Button {
            preferences.showSidebarCount = show
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 8) {
                        sidebarPreviewRow(
                            icon: "calendar",
                            label: "Today".localized,
                            count: show ? "3" : nil
                        )
                        sidebarPreviewRow(
                            icon: "folder.fill",
                            label: "Inbox".localized,
                            count: show ? "16" : nil
                        )
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.appBackground)
                    .cornerRadius(12)

                    if preferences.showSidebarCount == show {
                        SelectionBadge()
                            .offset(x: 4, y: -4)
                    }
                }

                Text(show ? "Show".localized : "Hide".localized)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
        .buttonStyle(.plain)
    }

    private func sidebarPreviewRow(icon: String, label: String, count: String?) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundColor(.appAccent)
                .frame(width: 16)

            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.textPrimary)

            Spacer()

            if let count {
                Text(count)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
    }

    private func listColorOption(show: Bool) -> some View {
        Button {
            preferences.showListColor = show
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 6) {
                            if show {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.appAccent)
                                    .frame(width: 3, height: 16)
                            }
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.textSecondary.opacity(0.3), lineWidth: 1)
                                .frame(width: 14, height: 14)
                            Text("Task Title".localized)
                                .font(.system(size: 10))
                                .foregroundColor(.textPrimary)
                        }
                        HStack(spacing: 6) {
                            if show {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.appAccent)
                                    .frame(width: 3, height: 16)
                            }
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.textSecondary.opacity(0.3), lineWidth: 1)
                                .frame(width: 14, height: 14)
                            Text("Task Title".localized)
                                .font(.system(size: 10))
                                .foregroundColor(.textPrimary)
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.appBackground)
                    .cornerRadius(12)

                    if preferences.showListColor == show {
                        SelectionBadge()
                            .offset(x: 4, y: -4)
                    }
                }

                Text(show ? "Show".localized : "Hide".localized)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
        .buttonStyle(.plain)
    }

    private func completedStyleOption(_ style: CompletedTaskStyle) -> some View {
        Button {
            preferences.completedTaskStyle = style
        } label: {
            VStack(spacing: 6) {
                ZStack(alignment: .topTrailing) {
                    VStack(alignment: .leading, spacing: 8) {
                        completedTaskPreviewRow(strikethrough: style == .strikethrough)
                        completedTaskPreviewRow(strikethrough: style == .strikethrough)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color.appBackground)
                    .cornerRadius(12)

                    if preferences.completedTaskStyle == style {
                        SelectionBadge()
                            .offset(x: 4, y: -4)
                    }
                }

                Text(style.displayName)
                    .font(.system(size: 11))
                    .foregroundColor(.textSecondary)
            }
        }
        .buttonStyle(.plain)
    }

    private func completedTaskPreviewRow(strikethrough: Bool) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "checkmark.square.fill")
                .font(.system(size: 14))
                .foregroundColor(.appAccent)

            Text("Task Title".localized)
                .font(.system(size: 10))
                .foregroundColor(.textSecondary)
                .strikethrough(strikethrough)
        }
    }
}
