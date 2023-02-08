import Foundation

@propertyWrapper
struct UrlPercentEncoding {
    var wrappedValue: URL
}

extension UrlPercentEncoding: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let str = try? container.decode(String.self),
            let encoded = str.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let url = URL(string: encoded)
        {

            self.wrappedValue = url

        } else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: container.codingPath, debugDescription: "Corrupted url"))
        }
    }
}

