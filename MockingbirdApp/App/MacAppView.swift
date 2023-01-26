import SwiftUI

struct MacAppView<Content: View>: View {
    @Binding var selectedTab: Tab
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(spacing: 0) {
            AppTabBar(tabs: Tab.allCases, selectedTab: $selectedTab)
                .frame(width: LayoutConfiguration.verticalTabBarWidth)
                .background(.thinMaterial)
            Divider()
            content()
        }
    }
}

struct MacAppView_Previews: PreviewProvider {
    static var previews: some View {
        MacAppView(selectedTab: .constant(Tab.home)) {
            VStack(alignment: .center) {
                HomeTab()
            }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
            .previewDevice("My Mac")
    }
}
