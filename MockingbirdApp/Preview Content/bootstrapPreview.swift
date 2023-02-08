import Foundation

func bootDependencyManager() {
    DependencyManager.boot()
}

func applyAuthenticatedAssemblies() {
    let userAuthenticatedTwitterClient = MockTwitterApiClient()

    DependencyManager.applyAuthenticatedAssemblies(
        userAuthenticatedTwitterClient: userAuthenticatedTwitterClient
    )
}
