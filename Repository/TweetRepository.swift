import Foundation

class TweetRepository {
    private let twitterApiClient: TwitterApiClient
    private let v2TweetsResponseConverter: V2TweetsResponseConverter

    init(twitterApiClient: TwitterApiClient, v2TweetsResponseConverter: V2TweetsResponseConverter) {
        self.twitterApiClient = twitterApiClient
        self.v2TweetsResponseConverter = v2TweetsResponseConverter
    }

    public func getTimeline() async throws -> [Tweet] {
        let responseBody = try await twitterApiClient.getV2ReverseChronologicalTimeline()
        return try v2TweetsResponseConverter.convert(from: responseBody)
        //let tweets = v2TweetsResponseConverter.convert(from: responseBody)
        //return RepositoryCollection<Tweet>()
    }
}
