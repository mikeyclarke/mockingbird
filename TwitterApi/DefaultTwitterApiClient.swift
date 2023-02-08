import Foundation

enum TwitterApiError: Error {
    case unauthorized
}

final class DefaultTwitterApiClient: TwitterApiClient {
    private static let baseUrl: String = "https://api.twitter.com"
    private let client: OauthHttpClient
    public let user: V2User

    public static func createUserAuthenticatedClient(with credentials: Credentials) async throws -> DefaultTwitterApiClient {
        let client = OauthHttpClient(baseUrl: baseUrl, credentials: credentials)
        let jsonDecoderFactory = ApiResponseDecoderFactory()
        let jsonDecoder = jsonDecoderFactory.create()
        client.setJsonDecoder(jsonDecoder)

        do {
            let responseBody: V2ResponseBody<V2User> = try await client.get(
                path: "/2/users/me?user.fields=profile_image_url,protected,verified,verified_type"
            )
            return DefaultTwitterApiClient(client: client, user: responseBody.data)
        } catch HttpClientError.badResponse(let statusCode) where statusCode == 401 {
            throw TwitterApiError.unauthorized
        }
    }

    init(client: OauthHttpClient, user: V2User) {
        self.client = client
        self.user = user
    }

    public func getV2ReverseChronologicalTimeline() async throws -> V2ResponseBody<[V2Tweet]> {
        return try await client.get(path: "/2/users/\(user.id)/timelines/reverse_chronological?tweet.fields=conversation_id,created_at,entities,public_metrics,referenced_tweets,reply_settings,attachments&expansions=author_id,referenced_tweets.id.author_id,attachments.media_keys&user.fields=profile_image_url,protected,verified,verified_type&media.fields=url,duration_ms,height,width,preview_image_url,alt_text,variants")
    }
}
