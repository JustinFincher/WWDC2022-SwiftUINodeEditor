import Foundation
extension Bundle {
    var versionString: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildString: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
