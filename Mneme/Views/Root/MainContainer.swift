import SwiftUI

struct MainContainer: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        ZStack(alignment: .bottom) {

            // ── Screen content ──
            ZStack {
                Color.appBackground.ignoresSafeArea()

                contentForSelectedTab
            }

            // ── Floating FAB ──
            if !state.showSearch {
                HStack {
                    Spacer()
                    FloatingFAB { state.showAddNote = true }
                        .padding(.trailing, 18)
                        .padding(.bottom, 90)
                }
            }

            // ── Tab bar ──
            if !state.showSearch {
                TabBarView()
                    .environmentObject(state)
                    .environmentObject(preferences)
            }
        }
        .overlay {
            if state.showSearch {
                SearchView()
                    .environmentObject(state)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeOut(duration: 0.25), value: state.showSearch)
        .sheet(isPresented: $state.showAddNote) {
            AddNoteSheet()
                .environmentObject(state)
                .presentationDetents([.height(195)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(22)
        }
    }

    // MARK: - Dynamic Tab Content

    @ViewBuilder
    private var contentForSelectedTab: some View {
        let tabs = preferences.enabledTabs
        let safeIndex = min(state.selectedTab, tabs.count - 1)
        let tab = tabs.indices.contains(safeIndex) ? tabs[safeIndex] : .task

        switch tab {
        case .task:
            NotesListView().environmentObject(state)
        case .calendar:
            CalendarView().environmentObject(state)
        case .settings:
            SettingsView()
                .environmentObject(state)
                .environmentObject(preferences)
        case .eisenhowerMatrix:
            placeholderView("Eisenhower Matrix".localized)
        case .pomodoro:
            placeholderView("Pomodoro".localized)
        case .habitTracker:
            placeholderView("Habit Tracker".localized)
        case .countdown:
            placeholderView("Countdown".localized)
        case .search:
            SearchView().environmentObject(state)
        }
    }

    private func placeholderView(_ title: String) -> some View {
        VStack(spacing: 12) {
            Spacer()
            Text(title)
                .font(.mnemeTitle)
                .foregroundColor(.textPrimary)
            Text("Coming Soon".localized)
                .font(.mnemeBody)
                .foregroundColor(.textSecondary)
            Spacer()
        }
    }
}
