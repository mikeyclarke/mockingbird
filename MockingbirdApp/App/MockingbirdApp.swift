import SwiftUI

@main
struct MockingbirdApp: App {
    @State private var selectedTab: Tab = .home

    var body: some Scene {
        WindowGroup {
            appView
        }
            #if os(macOS)
            .windowStyle(.hiddenTitleBar)
            .windowToolbarStyle(.automatic)
            #endif
    }

    @ViewBuilder
    private var appView: some View {
        let tabContents = ForEach(Tab.allCases) { tab in
            if tab == selectedTab {
                tab.makeContentView()
            }
        }

        if Device.isMac() {
            MacAppView(
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        } else if Device.isPad() {
            PadAppView(
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        } else {
            PhoneAppView(
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        }
    }
}
