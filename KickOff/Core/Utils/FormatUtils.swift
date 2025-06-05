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
        if  !LangManager.shared.isArabic {return self}
        for char in self {
            if let digit = char.wholeNumberValue {
                converted.append(arabicNumbers[digit])
            } else {
                converted.append(char)
            }
        }
        
        return converted
    }
    func toArabicDate() -> String {
        if  !LangManager.shared.isArabic {return self}
        let arabicNumerals: [Character: Character] = [
            "0": "٠", "1": "١", "2": "٢", "3": "٣", "4": "٤",
            "5": "٥", "6": "٦", "7": "٧", "8": "٨", "9": "٩"
        ]
        
        let parts = self.split(separator: "-")
        guard parts.count == 3 else { return self }
        
        let reordered = "\(parts[2])-\(parts[1])-\(parts[0])" // dd-MM-yyyy
        
        let converted = reordered.map { arabicNumerals[$0] ?? $0 }
        return String(converted)
    }
}




