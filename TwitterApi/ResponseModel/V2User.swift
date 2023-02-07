import Foundation

struct V2User: Codable, Identifiable {
    let id: String
    let name: String
    let username: String
    let profileImageUrl: URL
    let verified: Bool
    let protected: Bool
    let verifiedType: String
}
