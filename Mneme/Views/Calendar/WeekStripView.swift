import SwiftUI

/// Compact single-row week strip — pinned at top when month grid scrolls off
struct WeekStripView: View {
    @EnvironmentObject var state: AppState

    private let calendar = Calendar.current
    private let dayLabels = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        VStack(spacing: 0) {
            // Day-of-week header
            HStack(spacing: 0) {
                ForEach(dayLabels, id: \.self) { label in
                    Text(label)
                        .font(.system(size: 12))
                        .foregroundColor(.textSecondary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)

            // Week days
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
        }
        .contentShape(Rectangle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 30)
                .onEnded { value in
                    guard abs(value.translation.width) > abs(value.translation.height) else { return }
                    let direction = value.translation.width < 0 ? 1 : -1
                    withAnimation(.easeInOut(duration: 0.25)) {
                        state.calendarDate = calendar.date(
                            byAdding: .weekOfYear, value: direction, to: state.calendarDate
                        ) ?? state.calendarDate
                    }
                }
        )
    }
}
