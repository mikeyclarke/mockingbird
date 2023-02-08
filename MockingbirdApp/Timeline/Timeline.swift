import SwiftUI

struct Timeline: View {
    @StateObject private var viewModel = DependencyManager.assembler.resolver.resolve(TimelineViewModel.self)!
    @State var tweets: [Tweet] = []

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(tweets) { tweet in
                    TimelineTweet(tweet: tweet)
                }
            }
        }
            .onAppear {
                Task {
                    tweets = await viewModel.getTweets()
                }
            }
    }
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        bootDependencyManager()
        applyAuthenticatedAssemblies()
        return Timeline()
    }
}
