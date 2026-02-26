import SwiftUI

struct DailyNotificationView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences
    @State private var showTimePicker = false
    @State private var editingTimeIndex: Int? = nil
    @State private var pickerDate = Date()

    private var dayLabels: [String] {
        Calendar.current.veryShortWeekdaySymbols
    }

    var body: some View {
        SettingsPage(title: "Daily Notification".localized) {

            // ── Enable toggle ──
            SettingsSection {
                SettingsToggleRow(
                    label: "Daily Notification".localized,
                    isOn: $preferences.dailyNotificationEnabled,
                    subtitle: "An overview of Today's tasks at a fixed time every day (including overdue and all-day tasks).".localized
                )
            }

            // ── Notification times ──
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notification".localized)
                        .font(.mnemeBody)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: 12) {
                        ForEach(Array(preferences.notificationTimes.enumerated()), id: \.offset) { index, time in
                            Button {
                                editingTimeIndex = index
                                pickerDate = time
                                showTimePicker = true
                            } label: {
                                HStack(spacing: 6) {
                                    TimeChip(time: time)

                                    if preferences.notificationTimes.count > 1 {
                                        Button {
                                            deleteTime(at: index)
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 16))
                                                .foregroundColor(.textSecondary.opacity(0.6))
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }

                        AddChip {
                            editingTimeIndex = nil
                            pickerDate = Calendar.current.date(from: DateComponents(hour: 12, minute: 0)) ?? Date()
                            showTimePicker = true
                        }
                    }
                }
                .padding(.horizontal, Spacing.cardPadding)
                .padding(.vertical, 14)
            }

            // ── Type of Task for Notification ──
            SettingsSectionHeader(title: "Type of Task for Notification".localized)

            SettingsSection {
                SettingsToggleRow(
                    label: "Overdue Task".localized,
                    isOn: $preferences.overdueTaskNotification
                )

                Divider().padding(.leading, Spacing.cardPadding)

                SettingsToggleRow(
                    label: "All-Day Task".localized,
                    isOn: $preferences.allDayTaskNotification
                )
            }

            // ── Weekly Activation Date ──
            SettingsSection {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Weekly Activation Date".localized)
                        .font(.mnemeBody)
                        .foregroundColor(.textPrimary)

                    HStack(spacing: 8) {
                        ForEach(0..<7, id: \.self) { index in
                            DayPickerCircle(
                                label: dayLabels[index],
                                isSelected: preferences.weeklyActivationDays.contains(index)
                            ) {
                                toggleDay(index)
                                preferences.hapticIfEnabled(.selection)
                            }
                        }
                    }
                }
                .padding(.horizontal, Spacing.cardPadding)
                .padding(.vertical, 14)
            }
        }
        .sheet(isPresented: $showTimePicker) {
            timePickerSheet
                .presentationDetents([.height(280)])
                .presentationDragIndicator(.visible)
        }
    }

    // MARK: - Time Picker Sheet

    private var timePickerSheet: some View {
        VStack(spacing: 16) {
            Text(editingTimeIndex != nil ? "Edit Time".localized : "Add Time".localized)
                .font(.mnemeNavTitle)
                .padding(.top, 20)

            DatePicker(
                "",
                selection: $pickerDate,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .labelsHidden()

            Button {
                saveTime()
                showTimePicker = false
            } label: {
                Text("Done".localized)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.appAccent)
                    .cornerRadius(Radius.button)
            }
            .padding(.horizontal, Spacing.screenHorizontal)
            .padding(.bottom, 16)
        }
    }

    // MARK: - Actions

    private func toggleDay(_ index: Int) {
        if preferences.weeklyActivationDays.contains(index) {
            preferences.weeklyActivationDays.remove(index)
        } else {
            preferences.weeklyActivationDays.insert(index)
        }
    }

    private func saveTime() {
        if let index = editingTimeIndex {
            preferences.notificationTimes[index] = pickerDate
        } else {
            preferences.notificationTimes.append(pickerDate)
        }
        preferences.hapticIfEnabled(.success)
    }

    private func deleteTime(at index: Int) {
        preferences.notificationTimes.remove(at: index)
        preferences.hapticIfEnabled(.light)
    }
}
