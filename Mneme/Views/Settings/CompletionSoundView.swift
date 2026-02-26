import SwiftUI

struct CompletionSoundView: View {
    @EnvironmentObject var state: AppState
    @EnvironmentObject var preferences: UserPreferences

    var body: some View {
        SettingsPage(title: "Completion Sound".localized) {
            SettingsSection {
                ForEach(Array(CompletionSound.allCases.enumerated()), id: \.element.id) { index, sound in
                    if index > 0 {
                        Divider().padding(.leading, 52)
                    }

                    SettingsRadioRow(
                        label: sound.displayName,
                        isSelected: preferences.completionSound == sound
                    ) {
                        preferences.completionSound = sound
                        SoundManager.shared.play(sound)
                        preferences.hapticIfEnabled(.light)
                    }
                }
            }
        }
    }
}
