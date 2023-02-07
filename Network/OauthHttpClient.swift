import Foundation
import OhhAuth

enum HttpClientError: Error {
    case badResponse(statusCode: Int)
    case failedToDecodeResponse
}

class OauthHttpClient {
    private let baseUrl: String
    private let session: URLSession
    private let consumerCredentials: (key: String, secret: String)
    private let userCredentials: (key: String, secret: String)
    private let userAgent = "curl/7.86.0"
    private let success = 200..<300
    private var jsonDecoder: JSONDecoder = JSONDecoder()

    init(baseUrl: String, credentials: Credentials) {
        self.baseUrl = baseUrl
        self.session = URLSession.shared
        self.consumerCredentials = (key: credentials.consumerKey, secret: credentials.consumerSecret)
        self.userCredentials = (key: credentials.accessToken, secret: credentials.accessTokenSecret)
    }

    public func setJsonDecoder(_ jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    public func get<T: Codable>(path: String) async throws -> T {
        let request = createRequest(method: "GET", path: path)
        return try await getResponse(from: request, responseBodyType: T.self)
    }

    private func getResponse<T: Codable>(from request: URLRequest, responseBodyType: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)

        let httpResponse = response as? HTTPURLResponse
        guard success.contains(httpResponse!.statusCode) else {
            throw HttpClientError.badResponse(statusCode: httpResponse!.statusCode)
        }

        guard let result = try? jsonDecoder.decode(T.self, from: data) else {
            throw HttpClientError.failedToDecodeResponse
        }

        return result
    }

    private func createRequest(method: String, path: String, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        request.oAuthSign(
            method: method,
            body: body,
            contentType: nil,
            consumerCredentials: consumerCredentials,
            userCredentials: userCredentials
        )
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")

        return request
    }
}
