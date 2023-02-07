import Foundation

struct Media: Codable, Hashable, Identifiable {
    var id: String
    var type: String
    var width: Int
    var height: Int
    var variants: [Variant] = []
    var url: URL?
    var previewImageUrl: URL?
    var durationMiliseconds: Int?
    var altText: String?

    struct Variant: Codable, Hashable {
        var contentType: String
        var url: URL
        var bitRate: Int?
    }
}

extension Media {
    init(from apiModel: V2Media) {
        var variants: [Variant] = []
        if apiModel.variants != nil {
            variants = apiModel.variants!.map {
                Variant(
                    contentType: $0.contentType,
                    url: $0.url,
                    bitRate: $0.bitRate
                )
            }
        }

        self.init(
            id: apiModel.mediaKey,
            type: apiModel.type,
            width: apiModel.width,
            height: apiModel.height,
            variants: variants,
            url: apiModel.url,
            previewImageUrl: apiModel.previewImageUrl,
            durationMiliseconds: apiModel.durationMs,
            altText: apiModel.altText
        )
    }
}
