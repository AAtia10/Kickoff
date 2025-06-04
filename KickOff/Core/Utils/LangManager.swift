import Foundation

class LangManager {
    
    static let shared = LangManager()
    
    var fullLanguageIdentifier: String {
        return Locale.preferredLanguages.first ?? "en"
    }
    
    var languageCode: String {
        return fullLanguageIdentifier.components(separatedBy: "-").first ?? "en"
    }
    
    var isArabic: Bool {
        return languageCode == "ar"
    }
    
    var isEnglish: Bool {
        return languageCode == "en"
    }
    
    var appLanguage: String {
        return Bundle.main.preferredLocalizations.first ?? "en"
    }
    
    private init() {}
}

