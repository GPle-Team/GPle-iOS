public struct Token: Codable {
    public let accessToken: String
    public let accessExpiredAt: String
    public let refreshToken: String
    public let refreshExpiredAt: String
}
