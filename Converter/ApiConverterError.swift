import Foundation

enum ApiConverterError: Error {
    case referencedObjectMissing(objectType: String, objectId: String)
}
