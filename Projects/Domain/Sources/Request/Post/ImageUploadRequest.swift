import Foundation

public struct UploadRequest: Codable {
    var files: [Data]

    public init(files: [Data]) {
        self.files = files
    }
}
