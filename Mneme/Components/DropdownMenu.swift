import SwiftUI

// MARK: - More Menu (calendar "..." button)

struct MoreMenuDropdown: View {
    let onClose: () -> Void

    private let items: [(String, String)] = [
        ("line.horizontal.3.decrease.circle", "Filter View Range"),
        ("eye.circle",                        "View Options"),
        ("arrow.up.arrow.down.circle",        "Arrange Tasks"),
        ("calendar.badge.plus",               "Calendar Subscription"),
        ("square.and.arrow.up",               "Share"),
        ("printer",                           "Print"),
        ("checkmark.circle",                  "Select"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Button { onClose() } label: {
                    HStack(spacing: 14) {
                        Image(systemName: item.0)
                            .font(.system(size: 17))
                            .foregroundColor(.textPrimary)
                            .frame(width: 24)
                        Text(item.1)
                            .font(.mnemeBody)
                            .foregroundColor(.textPrimary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 13)
                }
                .buttonStyle(.plain)

                if index < items.count - 1 {
                    Divider().padding(.leading, 54)
                }
            }
        }
        .frame(width: 245)
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 6)
    }
}

// MARK: - View Mode Menu (calendar list/month/week picker)

struct ViewModeDropdown: View {
    let currentMode: String
    let onSelect: (String) -> Void

    private let modes: [(icon: String, name: String)] = [
        ("list.bullet",          "List"),
        ("square.grid.3x3",      "Year"),
        ("square.grid.3x2",      "Month"),
        ("rectangle.split.3x1", "Week"),
        ("rectangle.split.2x1", "3 Day"),
        ("rectangle",            "Day"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(modes, id: \.name) { mode in
                Button { onSelect(mode.name) } label: {
                    HStack(spacing: 12) {
                        Image(systemName: currentMode == mode.name ? "checkmark" : "")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.appAccent)
                            .frame(width: 18)

                        Image(systemName: mode.icon)
                            .font(.system(size: 16))
                            .foregroundColor(.textPrimary)
                            .frame(width: 22)

                        Text(mode.name)
                            .font(.mnemeBody)
                            .foregroundColor(.textPrimary)

                        Spacer()
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 13)
                }
                .buttonStyle(.plain)

                if mode.name != modes.last?.name {
                    Divider().padding(.leading, 52)
                }
            }
        }
        .frame(width: 205)
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 6)
    }
}
