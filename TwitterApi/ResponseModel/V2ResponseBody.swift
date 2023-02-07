import Foundation

struct V2Includes: Codable {
    let media: [V2Media]?
    let tweets: [V2Tweet]?
    let users: [V2User]?
}

struct V2Meta: Codable {
    let nextToken: String
    let resultCount: Int
    let newestId: String
    let oldestId: String
}

struct V2ResponseBody<Resource: Codable>: Codable {
    let data: Resource
    let includes: V2Includes?
    let meta: V2Meta?
}
