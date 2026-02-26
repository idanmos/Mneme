import SwiftUI

struct DayCellView: View {
    let date:       Date
    let isToday:    Bool
    let isSelected: Bool
    let hasDot:     Bool

    var body: some View {
        VStack(spacing: 3) {

            // ── Day number ──
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.appAccent)
                        .frame(width: 32, height: 32)
                }
                Text("\(date.dayNumber)")
                    .font(.system(
                        size: 14,
                        weight: (isToday || isSelected) ? .semibold : .regular
                    ))
                    .foregroundColor(
                        isSelected ? .white :
                        isToday    ? .appAccent :
                                     .textPrimary
                    )
            }

            // ── Dot indicator (has tasks) ──
            Circle()
                .fill(hasDot ? Color.appAccent.opacity(0.5) : Color.clear)
                .frame(width: 4, height: 4)
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
    }
}
