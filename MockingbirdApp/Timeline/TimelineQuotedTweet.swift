import SwiftUI

struct TimelineQuotedTweet: View {
	let tweet: Tweet
	let createdAtDisplay: String

    let maxTextLines = 5

    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    HStack {
                        Text(tweet.author.name).bold() + Text(" @\(tweet.author.username)")
                    }
                        .lineLimit(1)
                        .truncationMode(.tail)
                    Spacer()
                    Text(createdAtDisplay)
                }
                    .padding(.bottom, LayoutConfiguration.timelineTweetHeaderPaddingBottom)

                Text(tweet.text)
                    .lineLimit(maxTextLines)
                    .truncationMode(.tail)
            }
        }
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Theme.quotedTweetBackground)
            .clipShape(clipShape)
            .overlay {
                clipShape
                    .stroke(Theme.quotedTweetBorder, lineWidth: 1)
            }
    }

    private var clipShape: some Shape {
        return RoundedRectangle(cornerRadius: 10)
    }
}

struct TimelineQuotedTweet_Previews: PreviewProvider {
	static var author = User(
		id: "123",
		name: "GlasgowlovesEU #FBPE #ProgressiveAlliance🇺🇦",
		username: "GlasgowlovesEu",
		profileImageUrl: URL(string: "https://example.com")!
	)
	static var tweet = Tweet(
		id: "123",
		author: author,
		createdAt: Date(),
		text: "Q&A with Catherine Barnard, Professor of #European & Employment Law Cambridge, about the Retained EU Law Bill. Post your question as a reply #BrexitBritain"
	)
    static var previews: some View {
        TimelineQuotedTweet(tweet: tweet, createdAtDisplay: "18m")
            .frame(width: 254, height: 800)
    }
}
