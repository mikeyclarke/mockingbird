import Foundation

class TimelineViewModel: ObservableObject {
    private let tweetRepository: TweetRepository

    init(tweetRepository: TweetRepository) {
        self.tweetRepository = tweetRepository
    }

    public func getTweets() async -> [Tweet] {
        return try! await tweetRepository.getTimeline()
    }
}
