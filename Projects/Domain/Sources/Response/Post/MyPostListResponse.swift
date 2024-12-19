import Foundation

public struct MyPostListResponse: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [MyPostListTaggedUser]
    public let emojiList: MyPostListEmojiCounts
    public let createdTime: String
}

public struct MyPostListTaggedUser: Codable {
    public let username: String
    public let userId: Int
}

public struct MyPostListEmojiCounts: Codable {
    public let heartCount: Int
    public let congCount: Int
    public let thumbsCount: Int
    public let thinkCount: Int
    public let poopCount: Int
    public let chinaCount: Int
}
