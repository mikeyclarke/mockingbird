import Foundation

class TimelineViewModel: ObservableObject {
    private let tweetRepository: TweetRepository
    private let timeAgoFormatter: TimeAgoFormatter

    init(
        timeAgoFormatter: TimeAgoFormatter,
        tweetRepository: TweetRepository
    ) {
        self.timeAgoFormatter = timeAgoFormatter
        self.tweetRepository = tweetRepository
    }

    public func getTweets() async -> [Tweet] {
        return try! await tweetRepository.getTimeline()
    }

    public func timeAgo(from createdAt: Date) -> String {
        return timeAgoFormatter.format(date: createdAt)
    }
}
