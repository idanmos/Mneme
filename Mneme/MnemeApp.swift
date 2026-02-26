import SwiftUI

@main
struct MnemeApp: App {
    @StateObject private var preferences = UserPreferences()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(preferences)
                .preferredColorScheme(preferences.resolvedColorScheme)
                .onAppear {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}
