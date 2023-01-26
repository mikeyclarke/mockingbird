import SwiftUI

struct PhoneAppView<Content: View>: View {
    @Binding var selectedTab: Tab
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            content()
            Divider()
            AppTabBar(tabs: Tab.allCases, selectedTab: $selectedTab)
                .frame(width: .infinity)
                .background(.thinMaterial)
        }
    }
}

struct PhoneAppView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAppView(selectedTab: .constant(Tab.home)) {
            VStack(alignment: .center) {
                HomeTab()
            }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
            .previewDevice("iPhone 13 mini")
    }
}
