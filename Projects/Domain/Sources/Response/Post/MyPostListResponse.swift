import Foundation

public struct MyPostListResponse: Codable {
    public let id: Int
    public let author: AuthorInfo
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [MyPostListTaggedUser]
    public let emojiList: MyPostListEmojiCounts
    public let createdTime: String
}

public struct AuthorInfo: Codable {
    public let id: Int
    public let name: String
    public let grade: Int
}

public struct MyPostListTaggedUser: Codable {
    public let name: String
    public let id: Int
}

public struct MyPostListEmojiCounts: Codable {
    public let heartCount: Int
    public let congCount: Int
    public let thumbsCount: Int
    public let thinkCount: Int
    public let poopCount: Int
    public let chinaCount: Int

    init(_ counts: MyPostListEmojiCounts) {
            self.heartCount = counts.heartCount
            self.congCount = counts.congCount
            self.thumbsCount = counts.thumbsCount
            self.thinkCount = counts.thinkCount
            self.poopCount = counts.poopCount
            self.chinaCount = counts.chinaCount
        }
}
