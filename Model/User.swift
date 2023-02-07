import Foundation

struct User: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var username: String
    var profileImageUrl: URL
    var verified: Bool = false
    var protected: Bool = false

    var avatarImageUrl: URL {
        let urlString = profileImageUrl.absoluteString.replacingOccurrences(of: "_normal", with: "_x96")
        return URL(string: urlString)!
    }
}

extension User {
    init(from apiModel: V2User) {
        let verified = (apiModel.verified && apiModel.verifiedType != "blue")

        self.init(
            id: apiModel.id,
            name: apiModel.name,
            username: apiModel.username,
            profileImageUrl: apiModel.profileImageUrl,
            verified: verified,
            protected: apiModel.protected
        )
    }
}
