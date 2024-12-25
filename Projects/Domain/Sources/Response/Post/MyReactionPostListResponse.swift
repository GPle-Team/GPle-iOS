import Foundation

public struct MyReactionPostListResponse: Codable {
    public let id: Int
    public let author: ReactionAuthorInfo
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [MyReactionPostListTaggedUser]
    public let emojiList: MyReactionPostListEmojiCounts
    public let checkEmoji: MyReactionPostListEmojiState
    public let createdTime: String
}

public struct ReactionAuthorInfo: Codable {
    public let id: Int
    public let name: String
    public let grade: Int
}

public struct MyReactionPostListTaggedUser: Codable {
    public let name: String
    public let id: Int
}

public struct MyReactionPostListEmojiCounts: Codable {
    public let heartCount: Int
    public let congCount: Int
    public let thumbsCount: Int
    public let thinkCount: Int
    public let poopCount: Int
    public let chinaCount: Int
}

public struct MyReactionPostListEmojiState: Codable {
    public let heart: Bool
    public let cong: Bool
    public let thumbs: Bool
    public let think: Bool
    public let poop: Bool
    public let china: Bool
}
