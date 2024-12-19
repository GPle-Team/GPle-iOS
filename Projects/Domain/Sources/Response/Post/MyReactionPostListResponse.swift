import Foundation

public struct MyReactionPostListResponse: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [MyReactionPostListTaggedUser]
    public let emojiList: MyReactionPostListEmojiCounts
    public let createdTime: String
}

public struct MyReactionPostListTaggedUser: Codable {
    public let username: String
    public let userId: Int
}

public struct MyReactionPostListEmojiCounts: Codable {
    public let heartCount: Int
    public let congCount: Int
    public let thumbsCount: Int
    public let thinkCount: Int
    public let poopCount: Int
    public let chinaCount: Int
}
