public struct Post: Codable, Identifiable {
    public let id: Int
    public let author: Author
    public let title: String
    public let imageUrl: [String]
    public let location: String
    public let tagList: [Tag]
    public let emojiList: EmojiList
    public let createdTime: String

    public struct Author: Codable, Identifiable {
        public let id: Int
        public let name: String
        public let grade: Int
    }

    public struct Tag: Codable {
        public let name: String
        public let id: Int
    }

    public struct EmojiList: Codable {
        public let heartCount: Int
        public let congCount: Int
        public let thumbsCount: Int
        public let thinkCount: Int
        public let poopCount: Int
        public let chinaCount: Int
    }
}
