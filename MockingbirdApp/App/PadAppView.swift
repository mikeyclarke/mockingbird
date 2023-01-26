import SwiftUI

struct PadAppView<Content: View>: View {
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

struct PadAppView_Previews: PreviewProvider {
    static var previews: some View {
        PadAppView(selectedTab: .constant(Tab.home)) {
            VStack(alignment: .center) {
                HomeTab()
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
