import Swinject

final class TimelineAssembly: AuthenticatedAssembly, Assembly {
    private let userAuthenticatedTwitterClient: TwitterApiClient

    init(userAuthenticatedTwitterClient: TwitterApiClient) {
        self.userAuthenticatedTwitterClient = userAuthenticatedTwitterClient
    }

    public func assemble(container: Container) {
        container.register(TimelineViewModel.self) { r in
            TimelineViewModel(
                timeAgoFormatter: r.resolve(TimeAgoFormatter.self)!,
                tweetRepository: r.resolve(TweetRepository.self)!
            )
        }
    }
}
