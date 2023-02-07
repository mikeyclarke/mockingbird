import Foundation

struct Credentials: Codable {
    let consumerKey: String
    let consumerSecret: String
    let accessToken: String
    let accessTokenSecret: String
}
