import Foundation

public struct PopularityResponse: Codable {
    public let id: Int
    public let author: PopularityPostAuthorInfo
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [PopularityPostListTaggedUser]
    public let emojiList: PopularityPostListEmojiCounts
    public let checkEmoji: [Bool]
    public let createdTime: String
}

public struct PopularityPostAuthorInfo: Codable {
    public let id: Int
    public let name: String
    public let grade: Int
}

public struct PopularityPostListTaggedUser: Codable {
    public let name: String
    public let id: Int
}

public struct PopularityPostListEmojiCounts: Codable {
    public let heartCount: Int
    public let congCount: Int
    public let thumbsCount: Int
    public let thinkCount: Int
    public let poopCount: Int
    public let chinaCount: Int
}
