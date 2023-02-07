import Swinject

class AuthenticatedAssembler: Assembly {
    private let userAuthenticatedTwitterClient: TwitterApiClient

    init(userAuthenticatedTwitterClient: TwitterApiClient) {
        self.userAuthenticatedTwitterClient = userAuthenticatedTwitterClient
    }

    public func assemble(container: Container) {
        container.register(V2TweetsResponseConverter.self) { _ in
            V2TweetsResponseConverter()
        }

        container.register(TweetRepository.self) {[self] r in
            TweetRepository(
                twitterApiClient: self.userAuthenticatedTwitterClient,
                v2TweetsResponseConverter: r.resolve(V2TweetsResponseConverter.self)!
            )
        }

        container.register(TimelineViewModel.self) { r in
            TimelineViewModel(tweetRepository: r.resolve(TweetRepository.self)!)
        }
    }
}
