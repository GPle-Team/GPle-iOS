import Foundation

public struct FetchAllPostListResponse: Codable, Identifiable {
    public let id: Int
    public let posts: [Post]
    
    public struct Post: Codable, Identifiable {
        public let id: Int
        public let title: String
        public let userId: Int
        public let location: String
        public let tagList: [Tag]
        public let emojiList: EmojiList
        public let createdTime: String
        
        public struct Tag: Codable, Identifiable {
            public let id: Int
            public let username: String
            public let userId: Int
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
}
