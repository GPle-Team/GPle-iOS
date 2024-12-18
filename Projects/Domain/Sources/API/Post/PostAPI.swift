import Foundation
import Moya

public enum PostAPI {
    case createPost(param: CreatePostRequest, authorization: String)
    case uploadImage(files: [Data], authorization: String)
    case allUserList(authorization: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://active-weasel-fluent.ngrok-free.app")!
    }

    public var path: String {
        switch self {
        case .createPost:
            return ""
        case .uploadImage:
            return "/image/images"
        case .allUserList:
            return "/user"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .createPost, .uploadImage:
            return .post
        case .allUserList:
            return .get
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .createPost(let param, _):
            return .requestJSONEncodable(param)
        case .uploadImage(let files, _):
            let formData = files.map { fileData in
                MultipartFormData(provider: .data(fileData), name: "files", fileName: "image.jpg", mimeType: "image/jpeg")
            }
            return .uploadMultipart(formData)
        case .allUserList:
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .createPost(_, let authorization), .uploadImage(_, let authorization), .allUserList(let authorization):
            return ["Authorization": authorization]
        }
    }
}
