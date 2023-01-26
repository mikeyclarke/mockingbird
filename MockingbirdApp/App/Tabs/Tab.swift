import Foundation
import SwiftUI

enum Tab: String, Identifiable, Hashable, CaseIterable {
    case home
    case favorites

    var id: String {
        rawValue
    }

    var label: String {
        switch self {
            case .home:
                return "Home"
            case .favorites:
                return "Favorites"
        }
    }

    var icon: String {
        switch self {
            case .home:
                return "message"
            case .favorites:
                return "heart"
        }
    }

    @ViewBuilder
    func makeContentView() -> some View {
        switch self {
            case .home:
                HomeTab()
            case .favorites:
                FavoritesTab()
        }
    }
}
