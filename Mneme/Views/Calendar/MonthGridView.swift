import SwiftUI

struct MonthGridView: View {
    @EnvironmentObject var state: AppState

    private let calendar = Calendar.current
    private let columns   = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    private let dayLabels = ["S", "M", "T", "W", "T", "F", "S"]

    // Build the grid: nil for padding cells, Date for real days
    private var gridDays: [Date?] {
        let first   = state.displayedMonth.firstDayOfMonth
        let offset  = state.displayedMonth.firstWeekdayOfMonth
        let count   = state.displayedMonth.daysInMonth

        var days = [Date?](repeating: nil, count: offset)
        for i in 0..<count {
            days.append(calendar.date(byAdding: .day, value: i, to: first))
        }
        while days.count % 7 != 0 { days.append(nil) }
        return days
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Day-of-week header ──
            HStack(spacing: 0) {
                ForEach(dayLabels, id: \.self) { label in
                    Text(label)
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)

            if state.calendarCompact {
                // ── Week strip (compact) ──
                HStack(spacing: 0) {
                    ForEach(state.calendarDate.weekDays, id: \.self) { date in
                        DayCellView(
                            date:       date,
                            isToday:    calendar.isDateInToday(date),
                            isSelected: calendar.isDate(date, inSameDayAs: state.calendarDate),
                            hasDot:     state.hasNotes(on: date)
                        )
                        .onTapGesture { state.calendarDate = date }
                    }
                }
            } else {
                // ── Full month grid ──
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(Array(gridDays.enumerated()), id: \.offset) { _, date in
                        if let date {
                            DayCellView(
                                date:       date,
                                isToday:    calendar.isDateInToday(date),
                                isSelected: calendar.isDate(date, inSameDayAs: state.calendarDate),
                                hasDot:     state.hasNotes(on: date)
                            )
                            .onTapGesture { state.calendarDate = date }
                        } else {
                            Color.clear.frame(height: 44)
                        }
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    let isHorizontal = abs(value.translation.width) > abs(value.translation.height)
                    if isHorizontal {
                        let direction = value.translation.width < 0 ? 1 : -1
                        withAnimation(.easeInOut(duration: 0.25)) {
                            if state.calendarCompact {
                                state.calendarDate = calendar.date(
                                    byAdding: .weekOfYear, value: direction, to: state.calendarDate
                                ) ?? state.calendarDate
                            } else {
                                state.displayedMonth = state.displayedMonth.addingMonths(direction)
                            }
                        }
                    } else {
                        // Vertical swipe: toggle compact mode
                        withAnimation(.easeInOut(duration: 0.25)) {
                            if value.translation.height < 0 {
                                state.calendarCompact = true
                            } else {
                                state.calendarCompact = false
                            }
                        }
                    }
                }
        )
    }
}
