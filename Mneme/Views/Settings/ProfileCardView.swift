import SwiftUI

// MARK: - Profile Card

struct ProfileCardView: View {
    var body: some View {
        HStack(spacing: 14) {

            // Avatar
            ZStack(alignment: .topTrailing) {
                Circle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 66, height: 66)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.gray.opacity(0.7))
                    )
                // Crown badge
                ZStack {
                    Circle().fill(Color.badgeOrange).frame(width: 22, height: 22)
                    Image(systemName: "crown.fill").font(.system(size: 11)).foregroundColor(.white)
                }
                .offset(x: 4, y: -1)
            }

            // Info
            VStack(alignment: .leading, spacing: 5) {
                Text("Idan Moshe")
                    .font(.system(size: 18, weight: .semibold))

                HStack(spacing: 8) {
                    ProfileBadge(text: "✓ Lv.5",      bg: .green,                fg: .white)
                    ProfileBadge(text: "★ 11 Badges", bg: Color.gray.opacity(0.18), fg: .textPrimary)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.textSecondary)
        }
        .padding(18)
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
    }
}

struct ProfileBadge: View {
    let text: String; let bg: Color; let fg: Color
    var body: some View {
        Text(text)
            .font(.mnemeSmall)
            .foregroundColor(fg)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(bg)
            .cornerRadius(5)
    }
}

// MARK: - Settings Card

struct SettingsItem {
    let icon: String
    let label: String
    let iconBg: Color
    var trailingType: TrailingType = .none

    enum TrailingType {
        case none
        case text(String)
        case socialIcons
        case integrationIcons
    }
}

struct SettingsCard: View {
    let items: [SettingsItem]
    var onTap: ((Int) -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                Button {
                    onTap?(index)
                } label: {
                    HStack(spacing: 14) {

                        // Icon box
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(item.iconBg)
                                .frame(width: 28, height: 28)
                            Image(systemName: item.icon)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }

                        Text(item.label)
                            .font(.mnemeBody)
                            .foregroundColor(.textPrimary)

                        Spacer()

                        // Trailing area
                        trailingView(for: item.trailingType)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 13))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.horizontal, Spacing.cardPadding)
                    .padding(.vertical, 14)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                if index < items.count - 1 {
                    Divider().padding(.leading, 58)
                }
            }
        }
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
    }

    @ViewBuilder
    private func trailingView(for type: SettingsItem.TrailingType) -> some View {
        switch type {
        case .none:
            EmptyView()
        case .text(let value):
            Text(value)
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
        case .socialIcons:
            HStack(spacing: 3) {
                ForEach(["t", "r", "f", "i", "b"], id: \.self) { _ in
                    Circle().fill(Color.blue.opacity(0.75)).frame(width: 22, height: 22)
                }
            }
        case .integrationIcons:
            HStack(spacing: 3) {
                Circle().fill(Color.purple.opacity(0.7)).frame(width: 22, height: 22)
                Circle().fill(Color.blue.opacity(0.7)).frame(width: 22, height: 22)
                Circle().fill(Color.gray.opacity(0.3)).frame(width: 22, height: 22)
            }
        }
    }
}
