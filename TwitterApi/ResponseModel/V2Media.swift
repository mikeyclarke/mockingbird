import Foundation

struct V2Media: Codable, Identifiable {
    typealias ID = String

    let mediaKey: ID
    var id: ID { mediaKey }
    let width: Int
    let height: Int
    let type: String
    let variants: [V2MediaVariant]?
    let url: URL?
    let previewImageUrl: URL?
    let durationMs: Int?
    let altText: String?

    struct V2MediaVariant: Codable, Hashable {
        let contentType: String
        let url: URL
        let bitRate: Int?
    }
}
