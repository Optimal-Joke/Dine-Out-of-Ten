import Foundation

extension Date {
    func describeElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .weekOfYear, .day, .hour, .minute], from: self, to: Date())
        
        let description: String

        if let year = interval.year, year > 0 {
            description = (year == 1) ? "\(year) year ago" : "\(year) years ago"
        } else if let month = interval.month, month > 0 {
            description = (month == 1) ? "\(month) month ago" : "\(month) months ago"
        } else if let week = interval.weekOfYear, week > 0 {
            description = (week == 1) ? "last week" : "\(week) weeks ago"
        } else if let day = interval.day, day > 0 {
            description = (day == 1) ? "yesterday" : "\(day) days ago"
        } else {
            description = "today"
        }
        return description
    }
}

let longAgo = Date(timeIntervalSince1970: 0)
let lastWeek = Date(timeIntervalSinceNow: -605000)
let yesterday = Date(timeIntervalSinceNow: -864)
let now = Date()

now.describeElapsedInterval()
longAgo.describeElapsedInterval()
lastWeek.describeElapsedInterval()
yesterday.describeElapsedInterval()

