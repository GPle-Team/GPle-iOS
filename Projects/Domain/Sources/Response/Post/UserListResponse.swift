import Foundation

public struct UserListResponse: Identifiable, Codable {
    public let id: Int
    public let name: String
    public let grade: Int
    public let profileImage: String?
}
