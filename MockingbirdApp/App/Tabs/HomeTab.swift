import SwiftUI

struct HomeTab: View {
    let authenticatedUser: User

    var body: some View {
        let stack = VStack(alignment: .center) {
            Timeline()
        }
            .navigationTitle("Home")
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            #endif

        NavigationStack {
            if Device.isPhone() {
                #if !os(macOS)
                stack
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Avatar(
                                url: authenticatedUser.avatarImageUrl,
                                diameter: CGFloat(24)
                            )
                        }
                    }
                #endif
            } else {
                stack
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var authenticatedUser: User {
        User(
            id: "abcd1234",
            name: "Jack Sparrow",
            username: "captainjack",
            profileImageUrl: URL(string: "https://pbs.twimg.com/profile_images/1569656103528448000/d0BzVIPL_normal.jpg")!
        )
    }
    static var previews: some View {
        bootDependencyManager()
        applyAuthenticatedAssemblies()
        return HomeTab(authenticatedUser: authenticatedUser)
    }
}
