import SwiftUI

// MARK: - Settings Page Header

/// Back button + centered title, matching TickTick sub-page style
struct SettingsPageHeader: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        ZStack {
            Text(title)
                .font(.mnemeNavTitle)
                .frame(maxWidth: .infinity)

            HStack {
                RoundButton(icon: "chevron.left", action: onBack)
                Spacer()
            }
        }
        .padding(.top, 60)
        .padding(.bottom, 4)
    }
}

// MARK: - Settings Page Wrapper

/// Scrollable page with a back-button header
struct SettingsPage<Content: View>: View {
    let title: String
    @EnvironmentObject var state: AppState
    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                SettingsPageHeader(title: title) {
                    state.settingsPath.removeLast()
                }

                content()

                Spacer().frame(height: 100)
            }
            .padding(.horizontal, Spacing.screenHorizontal)
        }
        .background(Color.appBackground.ignoresSafeArea())
    }
}

// MARK: - Settings Section (White Card)

struct SettingsSection<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .background(Color.cardBackground)
        .cornerRadius(Radius.card)
    }
}

// MARK: - Section Header (gray label above a card)

struct SettingsSectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.mnemeCaption)
            .foregroundColor(.textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 4)
            .padding(.top, 4)
    }
}

// MARK: - Navigation Row

struct SettingsNavRow: View {
    let label: String
    var value: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.mnemeBody)
                    .foregroundColor(.textPrimary)

                Spacer()

                if let value {
                    Text(value)
                        .font(.system(size: 14))
                        .foregroundColor(.textSecondary)
                }

                Image(systemName: "chevron.right")
                    .font(.system(size: 13))
                    .foregroundColor(.textSecondary)
            }
            .padding(.horizontal, Spacing.cardPadding)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Toggle Row

struct SettingsToggleRow: View {
    let label: String
    @Binding var isOn: Bool
    var subtitle: String? = nil
    var isPremium: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 4) {
                    Text(label)
                        .font(.mnemeBody)
                        .foregroundColor(.textPrimary)

                    if isPremium {
                        Image(systemName: "crown.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.badgeOrange)
                    }
                }

                Spacer()

                Toggle("", isOn: $isOn)
                    .labelsHidden()
                    .tint(.appAccent)
            }

            if let subtitle {
                Text(subtitle)
                    .font(.mnemeCaption)
                    .foregroundColor(.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, 14)
    }
}

// MARK: - Radio Row

struct SettingsRadioRow: View {
    let label: String
    let isSelected: Bool
    var subtitle: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: subtitle != nil ? .top : .center, spacing: 14) {
                ZStack {
                    Circle()
                        .stroke(
                            isSelected ? Color.clear : Color.textSecondary.opacity(0.4),
                            lineWidth: 1.5
                        )
                        .frame(width: 22, height: 22)

                    if isSelected {
                        Circle()
                            .fill(Color.appAccent)
                            .frame(width: 22, height: 22)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, subtitle != nil ? 2 : 0)

                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.mnemeBody)
                        .foregroundColor(.textPrimary)

                    if let subtitle {
                        Text(subtitle)
                            .font(.mnemeCaption)
                            .foregroundColor(.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, Spacing.cardPadding)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Checkbox Row

struct SettingsCheckboxRow: View {
    let label: String
    let isSelected: Bool
    var subtitle: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: subtitle != nil ? .top : .center, spacing: 14) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.mnemeBody)
                        .foregroundColor(.textPrimary)

                    if let subtitle {
                        Text(subtitle)
                            .font(.mnemeCaption)
                            .foregroundColor(.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(
                            isSelected ? Color.clear : Color.textSecondary.opacity(0.4),
                            lineWidth: 1.5
                        )
                        .frame(width: 24, height: 24)

                    if isSelected {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.appAccent)
                            .frame(width: 24, height: 24)
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, Spacing.cardPadding)
            .padding(.vertical, 14)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Label Row (non-interactive)

struct SettingsLabelRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.mnemeBody)
                .foregroundColor(.textPrimary)

            Spacer()

            Text(value)
                .font(.system(size: 14))
                .foregroundColor(.textSecondary)
        }
        .padding(.horizontal, Spacing.cardPadding)
        .padding(.vertical, 14)
    }
}

// MARK: - Day Picker Circle

struct DayPickerCircle: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .textSecondary)
                .frame(width: 40, height: 40)
                .background(isSelected ? Color.appAccent : Color.appBackground)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Time Chip

struct TimeChip: View {
    let time: Date

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: time)
    }

    var body: some View {
        Text(timeString)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(Color.appAccent)
            .cornerRadius(20)
    }
}

// MARK: - Add Chip

struct AddChip: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: "plus")
                    .font(.system(size: 13, weight: .medium))
                Text("Add".localized)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.appAccent)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Selection Badge (blue checkmark circle)

struct SelectionBadge: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.appAccent)
                .frame(width: 20, height: 20)
            Image(systemName: "checkmark")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
