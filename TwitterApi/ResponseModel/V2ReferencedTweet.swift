import Foundation

struct V2ReferencedTweet: Codable {
    let id: String
    let type: String

    var isReply: Bool {
        return type == "replied_to"
    }
    var isQuoted: Bool {
        return type == "quoted"
    }
    var isRetweeted: Bool {
        return type == "retweeted"
    }
}
