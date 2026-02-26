import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack(alignment: .top) {

            VStack(spacing: 0) {

                // ── Header ──
                HStack {
                    RoundButton(icon: "line.3.horizontal") {
                        withAnimation { state.sidebarOpen.toggle() }
                        state.closeAllMenus()
                    }

                    Spacer()

                    Text(state.displayedMonth.monthName)
                        .font(.mnemeNavTitle)

                    Spacer()

                    // Right pill: layout icon + "..."
                    Button {
                        withAnimation(.easeOut(duration: 0.16)) {
                            state.showMoreMenu.toggle()
                            state.showViewMenu = false
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "rectangle.split.2x1")
                                .font(.system(size: 14))
                            Text("···")
                                .font(.system(size: 14, weight: .bold))
                                .tracking(1)
                        }
                        .foregroundColor(.textPrimary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 9)
                        .background(Color.cardBackground)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.06), radius: 4, y: 1)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 18)
                .padding(.top, 56)
                .padding(.bottom, 6)

                // ── Month grid ──
                MonthGridView()
                    .environmentObject(state)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 4)

                Divider()

                // ── Task list for selected day ──
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(dayHeader)
                            .font(.system(size: 13, weight: .bold))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)

                        let items = state.notes(for: state.calendarDate)

                        if items.isEmpty {
                            Text("No tasks for this day")
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top, 32)
                        } else {
                            ForEach(items) { note in
                                CalendarTaskRowView(note: note)
                                if note.id != items.last?.id {
                                    Divider().padding(.leading, 72)
                                }
                            }
                        }
                    }
                    .background(Color.cardBackground)
                    .cornerRadius(Radius.card)
                    .padding(.horizontal, 14)
                    .padding(.top, 10)
                    .padding(.bottom, 160)
                }
            }

            // ── Overlaid dropdowns ──
            if state.showMoreMenu {
                VStack {
                    Spacer().frame(height: 108)
                    HStack {
                        Spacer()
                        MoreMenuDropdown { withAnimation { state.showMoreMenu = false } }
                            .padding(.trailing, 14)
                    }
                }
                .zIndex(20)
                .transition(.opacity.combined(with: .scale(scale: 0.92, anchor: .topTrailing)))
            }

            if state.showViewMenu {
                VStack {
                    Spacer().frame(height: 108)
                    HStack {
                        ViewModeDropdown(currentMode: state.calendarMode) { mode in
                            state.calendarMode = mode
                            withAnimation { state.showViewMenu = false }
                        }
                        .padding(.leading, 14)
                        Spacer()
                    }
                }
                .zIndex(20)
                .transition(.opacity.combined(with: .scale(scale: 0.92, anchor: .topLeading)))
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { withAnimation { state.closeAllMenus() } }
    }

    private var dayHeader: String {
        state.calendarDate.isToday ? "TODAY" : state.calendarDate.dayHeaderLabel
    }
}
