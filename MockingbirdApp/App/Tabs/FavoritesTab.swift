import SwiftUI

struct FavoritesTab: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Timeline()
            }
                .navigationTitle("Favorites")
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                #endif
        }
    }
}

struct FavoritesTab_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTab()
    }
}
