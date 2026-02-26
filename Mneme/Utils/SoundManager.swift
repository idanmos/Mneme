import AudioToolbox
import AVFoundation

final class SoundManager {

    static let shared = SoundManager()

    private var soundIDs: [String: SystemSoundID] = [:]

    private init() {}

    /// Play a completion sound by its `CompletionSound` case.
    func play(_ sound: CompletionSound) {
        guard sound != .none else { return }
        playFile(named: sound.rawValue)
    }

    /// Play a reminder ringtone by its `ReminderRingtone` case.
    func play(_ ringtone: ReminderRingtone) {
        playFile(named: ringtone.rawValue)
    }

    // MARK: - Private

    private func playFile(named name: String) {
        if let cachedID = soundIDs[name] {
            AudioServicesPlaySystemSound(cachedID)
            return
        }

        // Try .wav first, then .caf, then .aiff
        let extensions = ["wav", "caf", "aiff", "mp3"]
        for ext in extensions {
            if let url = Bundle.main.url(forResource: name, withExtension: ext) {
                var soundID: SystemSoundID = 0
                let status = AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
                if status == kAudioServicesNoError {
                    soundIDs[name] = soundID
                    AudioServicesPlaySystemSound(soundID)
                    return
                }
            }
        }

        // Fallback: play system click
        AudioServicesPlaySystemSound(1104)
    }

    deinit {
        for (_, soundID) in soundIDs {
            AudioServicesDisposeSystemSoundID(soundID)
        }
    }
}
