import SwiftUI

struct ReminderRingtoneView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    /// When non-nil, we are picking a per-priority ringtone instead of the global one.
    var priorityLevel: PriorityLevel? = nil

    private var selectedRingtone: ReminderRingtone {
        if let level = priorityLevel {
            return preferences.ringtone(for: level)
        }
        return preferences.reminderRingtone
    }

    private var title: String {
        priorityLevel?.displayName ?? "Reminder Ringtone".localized
    }

    var body: some View {
        SettingsPage(title: title) {

            // ── Built-in ringtones ──
            SettingsSection {
                ForEach(Array(ReminderRingtone.allCases.enumerated()), id: \.element.id) { index, ringtone in
                    if index > 0 {
                        Divider().padding(.leading, 52)
                    }

                    SettingsRadioRow(
                        label: ringtone.displayName,
                        isSelected: selectedRingtone == ringtone
                    ) {
                        selectRingtone(ringtone)
                        SoundManager.shared.play(ringtone)
                        preferences.hapticIfEnabled(.light)
                    }
                }
            }

            // ── Custom Ringtone ──
            SettingsSection {
                Button {
                    // Custom ringtone import — future feature
                } label: {
                    HStack(spacing: 14) {
                        ZStack {
                            Circle()
                                .stroke(Color.textSecondary.opacity(0.4), lineWidth: 1.5)
                                .frame(width: 22, height: 22)
                        }

                        Text("Custom Ringtone".localized)
                            .font(.mnemeBody)
                            .foregroundColor(.textPrimary)

                        Spacer()

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

            Text("Only supports audio files in WAV format.".localized)
                .font(.mnemeCaption)
                .foregroundColor(.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
        }
    }

    private func selectRingtone(_ ringtone: ReminderRingtone) {
        if let level = priorityLevel {
            preferences.setRingtone(ringtone, for: level)
        } else {
            preferences.reminderRingtone = ringtone
        }
    }
}
