import SwiftUI

struct TimelineTweet: View {
    @StateObject private var viewModel = DependencyManager.assembler.resolver.resolve(TimelineTweetViewModel.self)!
	let tweet: Tweet

    var body: some View {
        HStack(alignment: .top, spacing: LayoutConfiguration.timelineTweetAvatarBodyGap) {
            TimelineAvatar(url: tweet.author.avatarImageUrl)
                .padding(.top, LayoutConfiguration.timelineTweetAvatarPaddingTop)

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        HStack {
                            Text(tweet.author.name).bold() + Text(" @\(tweet.author.username)")
                        }
                            .lineLimit(1)
                            .truncationMode(.tail)
                        Spacer()
                        if tweet.isThreaded {
                            Image(systemName: "bubble.left.and.bubble.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .accessibilityLabel("Part of a thread")
                        }
                        TimelineView(.everyMinute) { _ in
                            Text(viewModel.timeAgo(from: tweet.createdAt))
                                .font(.subheadline)
                        }
                        if tweet.isFavorited {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(Theme.favoritedIconColor)
                                .accessibilityLabel("Favorited")
                        }
                        if tweet.isPinned {
                            Image(systemName: "pin.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .accessibilityLabel("Pinned")
                        }
                    }
                        .padding(.bottom, LayoutConfiguration.timelineTweetHeaderPaddingBottom)

                    Text(tweet.text)

                    if tweet.hasMedia {
                        TimelineMedia()
                            .padding(.top, 15)
                    }

                    if tweet.hasQuotedTweet {
                        TimelineQuotedTweet(tweet: tweet.quotedTweet!)
                            .padding(.top, 15)
                    }

                    if tweet.isRetweet {
                        HStack {
                            Image(systemName: "arrow.2.squarepath")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .accessibilityLabel("Retweeted by")

                            HStack(alignment: .center, spacing: 4) {
                                Avatar(
                                    url: tweet.retweetedBy!.profileImageUrl,
                                    diameter: LayoutConfiguration.timelineRetweetAvatarDiameter
                                )
                                Text(tweet.retweetedBy!.name)
                            }
                        }
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .accessibilityElement(children: .combine)
                            .padding(.top, 15)
                    }
                }
                    .padding([.bottom, .trailing])

                Divider()
            }
        }
            .padding([.top, .leading])
    }

}

struct TimelineTweetRow_Previews: PreviewProvider {
	static var author = User(
		id: "123",
		name: "The Verge",
		username: "verge",
		profileImageUrl: URL(string: "https://pbs.twimg.com/profile_images/1569656103528448000/d0BzVIPL_normal.jpg")!
	)
	static var retweeter = User(
        id: "456",
        name: "Netflix",
        username: "netflix",
        profileImageUrl: URL(string: "https://pbs.twimg.com/profile_images/1235992718171467776/PaX2Bz1S_normal.jpg")!
	)
	static var quotedTweetAuthor = User(
		id: "123",
		name: "GlasgowlovesEU #FBPE #ProgressiveAlliance🇺🇦",
		username: "GlasgowlovesEu",
		profileImageUrl: URL(string: "https://example.com")!
	)
	static var quotedTweet = Tweet(
		id: "456",
		author: quotedTweetAuthor,
		createdAt: Date(),
		text: "Q&A with Catherine Barnard, Professor of #European & Employment Law Cambridge, about the Retained EU Law Bill. Post your question as a reply #BrexitBritain"
	)
	static var tweet = Tweet(
		id: "123",
		author: author,
		createdAt: Date(),
		text: "M. Night Shyamalan on season 4 of Servant and its “precision movement towards an end” theverge.com/2023/1/27/2357…",
		isThreaded: true,
		isRetweet: true,
		isFavorited: true,
		isPinned: true,
		hasQuotedTweet: true,
		quotedTweet: quotedTweet,
		retweetedBy: retweeter,
        retweetedAt: Date(),
        originalId: "789"
	)
    static var previews: some View {
        bootDependencyManager()
        applyAuthenticatedAssemblies()
        return TimelineTweet(tweet: tweet)
    }
}
