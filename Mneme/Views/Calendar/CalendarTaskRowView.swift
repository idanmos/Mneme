import SwiftUI

struct CalendarTaskRowView: View {
    let note: Note

    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            // ── Left time column (48pt) ──
            VStack(alignment: .trailing, spacing: 3) {
                // Time label
                Text(topTimeLabel)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.appAccent)

                // Icons row
                HStack(spacing: 3) {
                    if note.hasAlarm {
                        Image(systemName: "bell")
                            .font(.system(size: 9))
                            .foregroundColor(.textSecondary)
                    }
                    if note.isRecurring || note.isCalendarEvent {
                        Image(systemName: "repeat")
                            .font(.system(size: 9))
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            .frame(width: 48, alignment: .trailing)
            .padding(.top, 14)

            // ── Left indicator ──
            if note.isCalendarEvent {
                // Blue bar for subscribed calendar events
                Rectangle()
                    .fill(Color.calendarBlue)
                    .frame(width: 3)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 5)
            } else if note.isRecurring {
                // Red repeat icon for recurring tasks
                Image(systemName: "repeat")
                    .font(.system(size: 13))
                    .foregroundColor(.recurringRed)
                    .frame(width: 16)
                    .padding(.top, 14)
            } else {
                // Thin neutral line
                Rectangle()
                    .fill(Color.textSecondary.opacity(0.15))
                    .frame(width: 1)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 8)
            }

            // ── Main content ──
            VStack(alignment: .leading, spacing: 2) {
                if note.isCalendarEvent, let range = note.eventRange {
                    Text(range)
                        .font(.system(size: 12))
                        .foregroundColor(.appAccent)
                }
                Text(note.title)
                    .font(.mnemeBody)
                    .foregroundColor(.textPrimary)
            }
            .padding(.vertical, 12)
            .padding(.leading, 8)

            Spacer()

            // ── Right repeat icon ──
            Image(systemName: "repeat")
                .font(.system(size: 12))
                .foregroundColor(.textSecondary.opacity(0.4))
                .padding(.trailing, 14)
                .padding(.top, 15)
        }
    }

    // MARK: - Helpers

    private var topTimeLabel: String {
        if note.isCalendarEvent, let range = note.eventRange {
            return String(range.prefix(5))
        }
        if note.isRecurring || note.hasAlarm {
            return note.timeString
        }
        return "Today"
    }
}
