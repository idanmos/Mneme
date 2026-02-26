import SwiftUI

struct RootView: View {
    @StateObject private var state = AppState()
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        ZStack(alignment: .leading) {

            // ── Main content (shifts right when sidebar opens) ──
            MainContainer()
                .environmentObject(state)
                .environmentObject(preferences)
                .offset(x: state.sidebarOpen ? 285 : 0)
                .scaleEffect(state.sidebarOpen ? 0.975 : 1, anchor: .trailing)
                .animation(.spring(response: 0.3, dampingFraction: 0.86), value: state.sidebarOpen)

            // ── Dim overlay ──
            if state.sidebarOpen {
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .offset(x: 285)
                    .onTapGesture {
                        withAnimation { state.sidebarOpen = false }
                    }
            }

            // ── Sidebar panel ──
            SidebarView()
                .environmentObject(state)
                .frame(width: 285)
                .offset(x: state.sidebarOpen ? 0 : -285)
                .animation(.spring(response: 0.3, dampingFraction: 0.86), value: state.sidebarOpen)
        }
        .ignoresSafeArea()
    }
}
