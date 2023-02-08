import Swinject

final class RepositoryAssembly: AuthenticatedAssembly, Assembly {
    private let userAuthenticatedTwitterClient: TwitterApiClient

    init(userAuthenticatedTwitterClient: TwitterApiClient) {
        self.userAuthenticatedTwitterClient = userAuthenticatedTwitterClient
    }

    public func assemble(container: Container) {
        container.register(TweetRepository.self) {[self] r in
            TweetRepository(
                twitterApiClient: self.userAuthenticatedTwitterClient,
                v2TweetsResponseConverter: r.resolve(V2TweetsResponseConverter.self)!
            )
        }
    }
}
