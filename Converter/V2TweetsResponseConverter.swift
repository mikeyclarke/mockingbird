import Foundation

class V2TweetsResponseConverter {
    public func convert(from responseBody: V2ResponseBody<[V2Tweet]>) throws -> [Tweet] {
        let includedUsers = parseUsers(responseBody.includes?.users ?? [])
        let includedMedia = parseMedia(responseBody.includes?.media ?? [])
        let includedTweets = try parseReferencedTweets(
            responseBody.includes?.tweets ?? [],
            users: includedUsers,
            mediaList: includedMedia
        )

        var result: [Tweet] = []

        tweetLoop: for apiTweet in responseBody.data {
            guard let author = includedUsers[apiTweet.authorId] else {
                throw ApiConverterError.referencedObjectMissing(objectType: "User", objectId: apiTweet.authorId)
            }

            let mediaIds = apiTweet.attachments?.mediaKeys ?? []
            let media: [Media] = try mediaIds.map {
                guard let entry = includedMedia[$0] else {
                    throw ApiConverterError.referencedObjectMissing(objectType: "Media", objectId: $0)
                }
                return entry
            }

            let referencedTweets = apiTweet.referencedTweets ?? []
            for reference in referencedTweets {
                guard let referencedTweet = includedTweets[reference.id] else {
                    throw ApiConverterError.referencedObjectMissing(objectType: "Tweet", objectId: reference.id)
                }

                switch reference.type {
                    case "retweeted":
                        let tweet = Tweet(from: apiTweet, by: author, retweeting: referencedTweet)
                        result.append(tweet)

                        continue tweetLoop
                    case "quoted":
                        let tweet = Tweet(from: apiTweet, by: author, quoting: referencedTweet, withMedia: media)
                        result.append(tweet)

                        continue tweetLoop
                    default:
                        break
                }
            }

            let tweet = Tweet(from: apiTweet, by: author, withMedia: media)
            result.append(tweet)
        }

        return result
    }

    private func convertToTweet(_ apiTweet: V2Tweet, author: User, media: [Media] = []) -> Tweet {
        return Tweet(from: apiTweet, by: author, withMedia: media)
    }

    private func parseReferencedTweets(_ apiTweets: [V2Tweet], users: [String: User], mediaList: [String: Media]) throws -> [String: Tweet] {
        var result: [String: Tweet] = [:]

        for apiTweet in apiTweets {
            let id = apiTweet.id
            guard let author = users[apiTweet.authorId] else {
                throw ApiConverterError.referencedObjectMissing(objectType: "User", objectId: apiTweet.authorId)
            }

            var media: [Media] = []
            let mediaIds = apiTweet.attachments?.mediaKeys ?? []
            for mediaId in mediaIds {
                guard let entry = mediaList[mediaId] else {
                    continue
                }
                media.append(entry)
            }

            let tweet = convertToTweet(apiTweet, author: author, media: media)

            result[id] = tweet
        }

        return result
    }

    private func parseMedia(_ apiMediaList: [V2Media]) -> [String: Media] {
        var result: [String: Media] = [:]

        for apiMedia in apiMediaList {
            let id = apiMedia.mediaKey
            let media = Media(from: apiMedia)

            result[id] = media
        }

        return result
    }

    private func parseUsers(_ apiUsers: [V2User]) -> [String: User] {
        var result: [String: User] = [:]

        for apiUser in apiUsers {
            let id = apiUser.id
            let user = User(from: apiUser)

            result[id] = user
        }

        return result
    }
}
