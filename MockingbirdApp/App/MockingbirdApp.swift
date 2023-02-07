import SwiftUI
import Swinject

@main
struct MockingbirdApp: App {
    @State public var isAuthenticated: Bool = false
    @State private var selectedTab: Tab = .home

    init() {
        DependencyManager.boot()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if isAuthenticated {
                    appView
                } else {
                    UnauthenticatedView(isAuthenticated: $isAuthenticated)
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
