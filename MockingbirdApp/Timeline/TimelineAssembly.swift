import Swinject

final class TimelineAssembly: AuthenticatedAssembly, Assembly {
    private let userAuthenticatedTwitterClient: TwitterApiClient

    init(userAuthenticatedTwitterClient: TwitterApiClient) {
        self.userAuthenticatedTwitterClient = userAuthenticatedTwitterClient
    }

    public func assemble(container: Container) {
        container.register(TimelineViewModel.self) { r in
            TimelineViewModel(
                tweetRepository: r.resolve(TweetRepository.self)!
            )
        }

        container.register(TimelineTweetViewModel.self) { r in
            TimelineTweetViewModel(
                timeAgoFormatter: r.resolve(TimeAgoFormatter.self)!
            )
        }

        container.register(TimelineQuotedTweetViewModel.self) { r in
            TimelineQuotedTweetViewModel(
                timeAgoFormatter: r.resolve(TimeAgoFormatter.self)!
            )
        }
    }
}
