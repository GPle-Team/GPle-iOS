import Foundation

public struct UserInfoRequest: Codable {
    var name: String
    var number: String
    var file: Data?

    public init(name: String, number: String, file: Data?) {
        self.name = name
        self.number = number
        self.file = file
    }
    
    public init(name: String, number: String) {
        self.name = name
        self.number = number
    }
}
