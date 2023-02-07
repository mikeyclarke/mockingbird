import Foundation

class Tweet: Codable, Identifiable {
    var id: String
    var author: User
    var createdAt: Date
    var text: String
	var isThreaded: Bool = false
	var isRetweet: Bool = false
	var isFavorited: Bool = false
	var isPinned: Bool = false
	var hasQuotedTweet: Bool = false
	var hasMedia: Bool = false
	var media: [Media] = []
	var quotedTweet: Tweet? = nil
	var retweetedBy: User? = nil
	var retweetedAt: Date? = nil
	var originalId: String? = nil

    static func isThreaded(basedOn referencedTweets: [V2ReferencedTweet]?) -> Bool {
        if nil == referencedTweets {
            return false
        }

        return referencedTweets!.contains { $0.isReply }
    }

    init(
        id: String,
        author: User,
        createdAt: Date,
        text: String,
        isThreaded: Bool = false,
        isRetweet: Bool = false,
        isFavorited: Bool = false,
        isPinned: Bool = false,
        hasQuotedTweet: Bool = false,
        hasMedia: Bool = false,
        media: [Media] = [],
        quotedTweet: Tweet? = nil,
        retweetedBy: User? = nil,
        retweetedAt: Date? = nil,
        originalId: String? = nil
    ) {
        self.id = id
        self.author = author
        self.createdAt = createdAt
        self.text = text
        self.isThreaded = isThreaded
        self.isRetweet = isRetweet
        self.isFavorited = isFavorited
        self.isPinned = isPinned
        self.hasQuotedTweet = hasQuotedTweet
        self.hasMedia = hasMedia
        self.media = media
        self.quotedTweet = quotedTweet
        self.retweetedBy = retweetedBy
        self.retweetedAt = retweetedAt
        self.originalId = originalId
    }
}

extension Tweet {
    convenience init(from apiModel: V2Tweet, by author: User, withMedia media: [Media]) {
        self.init(
            id: apiModel.id,
            author: author,
            createdAt: apiModel.createdAt,
            text: apiModel.text,
            isThreaded: Self.isThreaded(basedOn: apiModel.referencedTweets),
            isRetweet: false,
            isFavorited: false,
            isPinned: false,
            hasQuotedTweet: false,
            hasMedia: !media.isEmpty,
            media: media
        )
    }

    convenience init(from apiModel: V2Tweet, by author: User, quoting quotedTweet: Tweet, withMedia media: [Media]) {
        self.init(
            id: apiModel.id,
            author: author,
            createdAt: apiModel.createdAt,
            text: apiModel.text,
            isThreaded: Self.isThreaded(basedOn: apiModel.referencedTweets),
            isRetweet: false,
            isFavorited: false,
            isPinned: false,
            hasQuotedTweet: true,
            hasMedia: !media.isEmpty,
            media: media,
            quotedTweet: quotedTweet
        )
    }

    convenience init(from apiModel: V2Tweet, by author: User, retweeting retweet: Tweet) {
        self.init(
            id: retweet.id,
            author: retweet.author,
            createdAt: retweet.createdAt,
            text: retweet.text,
            isThreaded: retweet.isThreaded,
            isRetweet: true,
            isFavorited: retweet.isFavorited,
            isPinned: false,
            hasQuotedTweet: retweet.hasQuotedTweet,
            hasMedia: retweet.hasMedia,
            media: retweet.media,
            quotedTweet: retweet.quotedTweet,
            retweetedBy: author,
            retweetedAt: apiModel.createdAt,
            originalId: apiModel.id
        )
    }
}
