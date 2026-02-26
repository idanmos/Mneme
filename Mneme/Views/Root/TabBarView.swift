import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(preferences.enabledTabs.enumerated()), id: \.element.id) { index, tab in
                TabBarItem(index: index, accentColor: accentColor(for: tab)) {
                    tabIcon(for: tab, isSelected: state.selectedTab == index)
                }
                .environmentObject(state)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
        .background(Color.cardBackground)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 3)
        .padding(.horizontal, 46)
        .padding(.bottom, 26)
        .onChange(of: preferences.enabledTabs) { _ in
            // Clamp selected tab if tabs changed
            if state.selectedTab >= preferences.enabledTabs.count {
                state.selectedTab = 0
            }
        }
    }

    // MARK: - Tab Icon

    @ViewBuilder
    private func tabIcon(for tab: SettingsTabItem, isSelected: Bool) -> some View {
        switch tab {
        case .calendar:
            CalendarTabIcon(isSelected: isSelected)
        default:
            Image(systemName: isSelected ? filledIcon(tab.icon) : tab.icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(isSelected ? .white : .textSecondary)
        }
    }

    private func accentColor(for tab: SettingsTabItem) -> Color {
        switch tab {
        case .task: .appAccent
        case .calendar: .textPrimary
        case .settings: .textPrimary
        default: .appAccent
        }
    }

    /// Return a filled variant of an SF Symbol if available.
    private func filledIcon(_ icon: String) -> String {
        if icon.hasSuffix(".fill") { return icon }
        let filled = icon + ".fill"
        // Common SF Symbols that have .fill variants
        let fillable = [
            "checkmark.square", "gearshape", "square.grid.2x2",
            "clock", "star", "magnifyingglass", "calendar"
        ]
        if fillable.contains(icon) { return filled }
        return icon
    }
}

// MARK: - Tab item with pill background

struct TabBarItem<Content: View>: View {
    @EnvironmentObject var state: AppState
    let index: Int
    let accentColor: Color
    @ViewBuilder let content: Content

    var isSelected: Bool { state.selectedTab == index }

    var body: some View {
        ZStack {
            if isSelected {
                Capsule()
                    .fill(accentColor)
                    .frame(width: 58, height: 40)
            }
            content
        }
        .frame(maxWidth: .infinity, minHeight: 40)
        .contentShape(Rectangle())
        .onTapGesture { state.selectedTab = index }
    }
}

// MARK: - Calendar icon with live date number

struct CalendarTabIcon: View {
    let isSelected: Bool
    private let day = Calendar.current.component(.day, from: .now)

    var body: some View {
        ZStack {
            // Base square
            RoundedRectangle(cornerRadius: 7)
                .fill(isSelected ? Color.white : Color.textPrimary)
                .frame(width: 28, height: 28)

            // Red/blue top strip
            VStack(spacing: 0) {
                Rectangle()
                    .fill(isSelected ? Color.appAccent : Color.recurringRed)
                    .frame(height: 8)
                Spacer()
            }
            .frame(width: 28, height: 28)
            .clipShape(RoundedRectangle(cornerRadius: 7))

            // Day number
            Text("\(day)")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(isSelected ? Color.textPrimary : .white)
                .offset(y: 4)
        }
        .frame(width: 28, height: 28)
    }
}
