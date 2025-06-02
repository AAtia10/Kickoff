import Foundation

class DateUtils {
    
    static func dateTwentyYearsAgo() -> String {
        let date = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
        return formatted(date)
    }
    
    static func dateFiveYearsAgo() -> String {
        let date = Calendar.current.date(byAdding: .year, value: -5, to: Date())!
        return formatted(date)
    }
    
    static func dateTwoMonthsAgo() -> String {
        let date = Calendar.current.date(byAdding: .month, value: -2, to: Date())!
        return formatted(date)
    }

    static func dateToday() -> String {
        return formatted(Date())
    }
    
    static func dateYesterday() -> String {
           let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
           return formatted(date)
    }

    static func dateNextMonth() -> String {
        let date = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        return formatted(date)
    }

    private static func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Africa/Cairo")
        return formatter.string(from: date)
    }
}
