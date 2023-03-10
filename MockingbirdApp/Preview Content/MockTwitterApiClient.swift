import Foundation

final class MockTwitterApiClient: TwitterApiClient {
    public func getV2ReverseChronologicalTimeline() async throws -> V2ResponseBody<[V2Tweet]> {
        let decoded: V2ResponseBody<[V2Tweet]> = loadAndDecode("v2_timeline_reverse_chronological.json")
        return decoded
    }
}

func loadAndDecode<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn’t find \(filename) in main bundle")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn’t load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoderFactory = ApiResponseDecoderFactory()
        let decoder = decoderFactory.create()

        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn’t parse \(filename) as \(T.self):\n\(error)")
    }
}
