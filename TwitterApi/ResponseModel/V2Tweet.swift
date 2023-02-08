import Foundation

struct V2Tweet: Codable, Identifiable {
    let id: String
    let text: String
    let authorId: String
    let createdAt: Date
    let attachments: Attachments?
    let conversationId: String?
    let entities: Entities?
    let inReplyToUserId: String?
    let publicMetrics: PublicMetrics?
    let referencedTweets: [V2ReferencedTweet]?
    let replySettings: String?

    struct Attachments: Codable {
        let pollIds: [String]?
        let mediaKeys: [String]?
    }

    struct HashtagEntity: Codable {
        let start: Int
        let end: Int
        let tag: String
    }

    struct MentionEntity: Codable {
        let id: String
        let start: Int
        let end: Int
        let username: String
    }

    struct UrlEntity: Codable {
        let start: Int
        let end: Int
        let url: URL
        @UrlPercentEncoding var expandedUrl: URL
        let displayUrl: String
        let title: String?
        let description: String?
        let mediaKey: String?
    }

    struct Entities: Codable {
        let hashtags: [HashtagEntity]?
        let mentions: [MentionEntity]?
        let urls: [UrlEntity]?
    }

    struct PublicMetrics: Codable {
        let retweetCount: Int
        let replyCount: Int
        let likeCount: Int
        let quoteCount: Int
        let impressionCount: Int
    }
}
