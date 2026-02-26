import SwiftUI

struct MainContainer: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack(alignment: .bottom) {

            // ── Screen content ──
            ZStack {
                Color.appBackground.ignoresSafeArea()

                switch state.selectedTab {
                case 0:  NotesListView().environmentObject(state)
                case 1:  CalendarView().environmentObject(state)
                default: SettingsView().environmentObject(state)
                }
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
                TabBarView().environmentObject(state)
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
}
