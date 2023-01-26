import SwiftUI

struct HomeTab: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("Hello")
            }
                .navigationTitle("Home")
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
            #endif
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
    }
}
