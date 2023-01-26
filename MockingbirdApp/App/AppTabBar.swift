import SwiftUI

struct AppTabBar: View {
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
        ForEach(tabs) { tab in
            createTab(tab)
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
    static var previews: some View {
        AppTabBar(
            tabs: Tab.allCases,
            selectedTab: .constant(Tab.home)
        )
    }
}
