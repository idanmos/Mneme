import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        HStack(spacing: 0) {
            // 0 — Notes (checkmark)
            TabBarItem(index: 0, accentColor: .appAccent) {
                Image(systemName: state.selectedTab == 0 ? "checkmark.square.fill" : "checkmark.square")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(state.selectedTab == 0 ? .white : .textSecondary)
            }
            .environmentObject(state)

            // 1 — Calendar (live day number)
            TabBarItem(index: 1, accentColor: .textPrimary) {
                CalendarTabIcon(isSelected: state.selectedTab == 1)
            }
            .environmentObject(state)

            // 2 — Settings (gear)
            TabBarItem(index: 2, accentColor: .textPrimary) {
                Image(systemName: state.selectedTab == 2 ? "gearshape.fill" : "gearshape")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(state.selectedTab == 2 ? .white : .textSecondary)
            }
            .environmentObject(state)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
        .background(Color.cardBackground)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 3)
        .padding(.horizontal, 46)
        .padding(.bottom, 26)
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
