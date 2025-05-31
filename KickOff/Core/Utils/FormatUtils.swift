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
