import SwiftUI

// MARK: - App Color Palette
// All colors extracted directly from TickTick screenshots

extension Color {

    // ── Backgrounds ──
    static let appBackground  = Color(hex: "ECEDF4")   // lavender-gray screen bg
    static let cardBackground = Color.white

    // ── Accent ──
    static let appAccent      = Color(hex: "4F6EFF")   // primary blue

    // ── Sidebar ──
    static let sidebarBg      = Color(hex: "1C2B5E")   // dark navy
    static let sidebarSelected = Color(hex: "2D3F7A")  // selected row

    // ── Text ──
    static let textPrimary    = Color(hex: "1C1C1E")
    static let textSecondary  = Color(hex: "8E8E93")

    // ── Semantic ──
    static let calendarBlue   = Color(hex: "6482FF")   // calendar event left border
    static let recurringRed   = Color(hex: "FF3B30")   // recurring task icon
    static let badgeOrange    = Color(hex: "FF9500")

    // MARK: - Hex initializer

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double( int        & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Typography

extension Font {
    static let mnemeTitle      = Font.system(size: 30, weight: .bold)
    static let mnemeNavTitle   = Font.system(size: 17, weight: .semibold)
    static let mnemeBody       = Font.system(size: 15)
    static let mnemeCaption    = Font.system(size: 12)
    static let mnemeSmall      = Font.system(size: 11, weight: .medium)
}

// MARK: - Spacing

enum Spacing {
    static let screenHorizontal: CGFloat = 16
    static let cardPadding: CGFloat      = 16
    static let rowVertical: CGFloat      = 13
    static let sidebarRowV: CGFloat      = 13
    static let sidebarHorizontal: CGFloat = 20
}

// MARK: - Corner Radius

enum Radius {
    static let card: CGFloat    = 16
    static let sidebar: CGFloat = 11
    static let button: CGFloat  = 21
}
