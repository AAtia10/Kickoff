import Foundation

class FormatUtils {
    
    static func splitMatchResult(_ result: String?) -> [String]? {
        guard let result = result else {
            return nil
        }
        
        let trimmed = result.trimmingCharacters(in: .whitespacesAndNewlines)
        let scores = trimmed.components(separatedBy: " - ")
        
        guard scores.count == 2 else {
            return nil
        }
        
        return scores
    }
}

extension String {
    func convertEnglishDigitsToArabic() -> String {
        let arabicNumbers = ["٠","١","٢","٣","٤","٥","٦","٧","٨","٩"]
        var converted = ""
        
        for char in self {
            if let digit = char.wholeNumberValue {
                converted.append(arabicNumbers[digit])
            } else {
                converted.append(char)
            }
        }
        
        return converted
    }
}

