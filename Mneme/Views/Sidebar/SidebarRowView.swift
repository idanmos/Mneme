import SwiftUI

struct SidebarRowView: View {
    let folder: Folder
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 14) {

            // ── Icon ──
            Group {
                if folder.isSpecial {
                    TodayCalendarIcon()
                } else {
                    Image(systemName: folder.sfSymbol)
                        .font(.system(size: 15))
                        .foregroundColor(folder.iconColor)
                        .frame(width: 26)
                }
            }
            .frame(width: 26)

            // ── Name ──
            Text(folder.name)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .foregroundColor(.white)
                .lineLimit(1)

            Spacer()

            // ── Count ──
            if let count = folder.count {
                Text("\(count)")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }

            // ── Disclosure arrow ──
            if folder.hasDisclosureArrow {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.4))
            }
        }
        .padding(.vertical, Spacing.sidebarRowV)
        .padding(.horizontal, 14)
        .background(isSelected ? Color.sidebarSelected : Color.clear)
        .cornerRadius(Radius.sidebar)
        .padding(.horizontal, 9)
    }
}

// MARK: - "Today" custom icon (orange calendar with date number)

private struct TodayCalendarIcon: View {
    private let day = Calendar.current.component(.day, from: .now)

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.orange)
                .frame(width: 26, height: 26)

            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.recurringRed)
                    .frame(height: 7)
                Spacer()
            }
            .frame(width: 26, height: 26)
            .clipShape(RoundedRectangle(cornerRadius: 5))

            Text("\(day)")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white)
                .offset(y: 3)
        }
        .frame(width: 26, height: 26)
    }
}
