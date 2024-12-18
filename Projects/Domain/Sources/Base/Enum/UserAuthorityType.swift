import Foundation

public enum UserAuthorityType: String, CaseIterable, Decodable, Encodable {
    case user = "ROLE_USER"
    case admin = "ROLE_ADMIN"
}
