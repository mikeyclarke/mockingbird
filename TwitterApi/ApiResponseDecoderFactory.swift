import Foundation

class ApiResponseDecoderFactory {
    public func create() -> JSONDecoder {
        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd'T'H:mm:ss.SSSXXXXX"

        decoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            if let date = formatter.date(from: dateString) {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        })

        return decoder
    }
}
