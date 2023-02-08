import Foundation

class TimelineQuotedTweetViewModel: ObservableObject {
    private let timeAgoFormatter: TimeAgoFormatter

    init(
        timeAgoFormatter: TimeAgoFormatter
    ) {
        self.timeAgoFormatter = timeAgoFormatter
    }

    public func timeAgo(from createdAt: Date) -> String {
        return timeAgoFormatter.format(date: createdAt)
    }
}
