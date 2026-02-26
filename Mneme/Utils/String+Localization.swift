import Foundation

extension String {
    /// Returns the localized version of this string
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    /// Returns the localized version of this string with arguments
    func localized(_ arguments: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
}
