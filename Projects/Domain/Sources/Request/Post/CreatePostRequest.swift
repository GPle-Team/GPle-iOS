import Foundation

public struct CreatePostRequest: Codable {
    var title: String
    var location: String
    var userList: [Int]
    var imageUrl: [String]

    public init(title: String, location: String, userList: [Int], imageUrl: [String]) {
        self.title = title
        self.location = location
        self.userList = userList
        self.imageUrl = imageUrl
    }
}
