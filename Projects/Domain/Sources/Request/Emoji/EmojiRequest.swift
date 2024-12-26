import Foundation

public struct EmojiRequest: Codable {
    var postId: Int
    var emojiType: String

    public init(postId: Int, emojiType: String) {
        self.postId = postId
        self.emojiType = emojiType
    }
}
