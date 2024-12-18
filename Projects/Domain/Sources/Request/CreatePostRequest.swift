import Foundation

public struct CreatePostRequest: Codable {
    var title: String
    var location: String
    var userList: [Int64]
    var imageUrl: [String]

    public init(title: String, location: String, userList: [Int64], imageUrl: [String]) {
        self.title = title
        self.location = location
        self.userList = userList
        self.imageUrl = imageUrl
    }
}
