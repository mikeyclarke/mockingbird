import SwiftUI

struct AppTabBar: View {
    let authenticatedUser: User
    var tabs: [Tab]
    @Binding var selectedTab: Tab

    var body: some View {
        if Device.isPhone() {
            HStack(spacing: 0) {
                distributedTabList
            }
        } else {
            VStack(spacing: 0) {
                tabList
                Spacer()
            }
        }
    }

    private func createTab(_ tab: Tab) -> some View {
        let isSelected = (selectedTab == tab)

        return Button {
            selectedTab = tab
        } label: {
            ZStack {
                Image(systemName: isSelected ? "\(tab.icon).fill" : tab.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: LayoutConfiguration.tabIconDiameter, height: LayoutConfiguration.tabIconDiameter)
                    .accessibilityLabel(tab.label)
                    .foregroundColor(isSelected ? .accentColor : .primary)
            }
                .contentShape(Rectangle())
                .frame(width: LayoutConfiguration.horizontalTabBarHeight, height: LayoutConfiguration.verticalTabBarWidth)
        }
            .buttonStyle(.plain)
    }

    private var tabList: some View {
        Group {
            Avatar(
                url: authenticatedUser.avatarImageUrl,
                diameter: CGFloat(36)
            )
            ForEach(tabs) { tab in
                createTab(tab)
            }
        }
    }

    private var distributedTabList: some View {
        ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
            if index == 0 {
                Spacer()
            }
            createTab(tab)
            Spacer()
        }
    }
}

struct AppTabBar_Previews: PreviewProvider {
    static var authenticatedUser: User {
        User(
            id: "abcd1234",
            name: "Jack Sparrow",
            username: "captainjack",
            profileImageUrl: URL(string: "https://pbs.twimg.com/profile_images/1569656103528448000/d0BzVIPL_normal.jpg")!
        )
    }
    static var previews: some View {
        AppTabBar(
            authenticatedUser: authenticatedUser,
            tabs: Tab.allCases,
            selectedTab: .constant(Tab.home)
        )
    }
}
