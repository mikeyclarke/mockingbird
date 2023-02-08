import SwiftUI

struct UnauthenticatedView: View {
    @Binding var isAuthenticated: Bool

    var body: some View {
        HStack {
            VStack {
                Button(
                    action: {
                        Task {
                            let credentials = Credentials(
                                consumerKey: try! Configuration.value(for: "TWITTER_CONSUMER_KEY"),
                                consumerSecret: try! Configuration.value(for: "TWITTER_CONSUMER_SECRET"),
                                accessToken: try! Configuration.value(for: "TWITTER_ACCESS_TOKEN"),
                                accessTokenSecret: try! Configuration.value(for: "TWITTER_ACCESS_TOKEN_SECRET")
                            )
                            let userAuthenticatedTwitterClient = try! await DefaultTwitterApiClient.createUserAuthenticatedClient(with: credentials)
                            DependencyManager.applyAuthenticatedAssemblies(
                                userAuthenticatedTwitterClient: userAuthenticatedTwitterClient
                            )

                            isAuthenticated = true
                        }
                    },
                    label: {
                        Text("Sign into Twitter")
                    }
                )
            }
        }
    }
}

struct UnauthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        UnauthenticatedView(isAuthenticated: .constant(false))
    }
}
