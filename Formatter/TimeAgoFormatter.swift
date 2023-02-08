import Foundation

fileprivate let minute: Double = 60
fileprivate let hour: Double = minute * 60
fileprivate let day: Double = hour * 24
fileprivate let year: Double = day * 365
fileprivate let yearAndHalf: Double = year * 1.5

class TimeAgoFormatter {
    public func format(date: Date) -> String {
        let timeInterval = abs(date.timeIntervalSinceNow)

        if timeInterval < minute {
            return "<1m"
        }

        if timeInterval < hour {
            return "\(Int(timeInterval / minute))m"
        }

        if timeInterval < day {
            return "\(Int(timeInterval / hour))h"
        }

        if timeInterval < yearAndHalf {
            return "\(Int(timeInterval / day))d"
        }

        return "\(Int(timeInterval / year))y"
    }
}
