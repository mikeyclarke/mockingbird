import SwiftUI

struct PadAppView<Content: View>: View {
    let authenticatedUser: User
    @Binding var selectedTab: Tab
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(spacing: 0) {
            AppTabBar(authenticatedUser: authenticatedUser, tabs: Tab.allCases, selectedTab: $selectedTab)
                .frame(width: LayoutConfiguration.verticalTabBarWidth)
                .background(.thinMaterial)
            Divider()
            content()
        }
    }
}

struct PadAppView_Previews: PreviewProvider {
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
        return PadAppView(authenticatedUser: authenticatedUser, selectedTab: .constant(Tab.home)) {
            VStack(alignment: .center) {
                HomeTab(authenticatedUser: authenticatedUser)
            }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
            .previewDevice("iPad mini (6th generation)")
    }
}
