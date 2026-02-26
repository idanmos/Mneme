import SwiftUI

private struct MonthGridBottomKey: PreferenceKey {
    static var defaultValue: CGFloat = 1000
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CalendarView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ZStack(alignment: .top) {

            VStack(spacing: 0) {

                // ── Fixed header ──
                HStack {
                    RoundButton(icon: "line.3.horizontal") {
                        withAnimation { state.sidebarOpen.toggle() }
                        state.closeAllMenus()
                    }

                    Spacer()

                    // Dual-line header when compact
                    VStack(spacing: 1) {
                        if state.calendarCompact {
                            Text(state.displayedMonth.monthName)
                                .font(.system(size: 13))
                                .foregroundColor(.textSecondary)
                        }
                        Text(state.calendarCompact
                             ? state.calendarDate.compactHeaderLabel
                             : state.displayedMonth.monthName)
                            .font(.mnemeNavTitle)
                    }
                    .animation(.easeInOut(duration: 0.2), value: state.calendarCompact)

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

                // ── Scrollable content area ──
                ZStack(alignment: .top) {

                    // Single scroll view with everything
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {

                            // Month grid (scrolls with content)
                            MonthGridView()
                                .environmentObject(state)
                                .padding(.horizontal, 12)
                                .padding(.bottom, 4)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear.preference(
                                            key: MonthGridBottomKey.self,
                                            value: geo.frame(in: .named("calScroll")).maxY
                                        )
                                    }
                                )

                            Divider()

                            // Day header
                            Text(dayHeader)
                                .font(.system(size: 13, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 12)

                            // Task list
                            let items = state.notes(for: state.calendarDate)

                            if items.isEmpty {
                                Text("No tasks for this day")
                                    .font(.system(size: 14))
                                    .foregroundColor(.textSecondary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.top, 32)
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(items) { note in
                                        CalendarTaskRowView(note: note)
                                        if note.id != items.last?.id {
                                            Divider().padding(.leading, 72)
                                        }
                                    }
                                }
                                .background(Color.cardBackground)
                                .cornerRadius(Radius.card)
                                .padding(.horizontal, 14)
                            }

                            Spacer().frame(height: 160)
                        }
                    }
                    .coordinateSpace(name: "calScroll")
                    .onPreferenceChange(MonthGridBottomKey.self) { maxY in
                        let shouldBeCompact = maxY < 20
                        if shouldBeCompact != state.calendarCompact {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                state.calendarCompact = shouldBeCompact
                            }
                        }
                    }

                    // ── Pinned compact week strip (overlays when month grid scrolled off) ──
                    if state.calendarCompact {
                        VStack(spacing: 0) {
                            WeekStripView()
                                .environmentObject(state)
                                .padding(.horizontal, 12)
                                .padding(.bottom, 4)
                            Divider()
                        }
                        .background(Color.appBackground)
                        .transition(.opacity)
                    }
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
