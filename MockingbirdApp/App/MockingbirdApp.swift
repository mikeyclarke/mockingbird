import SwiftUI
import Swinject

@main
struct MockingbirdApp: App {
    @State private var authenticatedUser: User? = nil
    @State private var selectedTab: Tab = .home

    init() {
        DependencyManager.boot()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if nil != authenticatedUser {
                    appView
                } else {
                    UnauthenticatedView(authenticatedUser: $authenticatedUser)
                }
            }
                #if os(macOS)
                .frame(
                    minWidth: LayoutConfiguration.macosWindowInitialWidth,
                    maxWidth: .infinity,
                    minHeight: LayoutConfiguration.macosWindowInitialHeight,
                    maxHeight: .infinity,
                    alignment: .center
                )
                #endif
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
                tab.makeContentView(authenticatedUser: authenticatedUser!)
            }
        }

        if Device.isMac() {
            MacAppView(
                authenticatedUser: authenticatedUser!,
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        } else if Device.isPad() {
            PadAppView(
                authenticatedUser: authenticatedUser!,
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        } else {
            PhoneAppView(
                authenticatedUser: authenticatedUser!,
                selectedTab: $selectedTab
            ) {
                tabContents
            }
        }
    }
}
