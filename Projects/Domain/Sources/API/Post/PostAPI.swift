import Foundation
import Moya

public enum PostAPI {
    case createPost(param: CreatePostRequest, authorization: String)
    case uploadImage(files: [Data], authorization: String)
    case allUserList(authorization: String)
    case myPostList(authorization: String)
    case myReactionPostList(authorization: String)
    case popularityPostList(authorization: String)
    case popularityUserList(authorization: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .createPost, .myPostList, .myReactionPostList, .popularityPostList:
            return "/post"
        case .uploadImage:
            return "/file/images"
        case .allUserList:
            return "/user"
        case .popularityUserList:
            return "/user/popularity"
        }
    }


    public var method: Moya.Method {
        switch self {
        case .createPost, .uploadImage:
            return .post
        case .allUserList, .myPostList, .myReactionPostList, .popularityPostList, .popularityUserList:
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
        case .allUserList, .popularityUserList:
            return .requestPlain
        case .myPostList:
            return .requestParameters(parameters: ["type": "MY"], encoding: URLEncoding.queryString)
        case .myReactionPostList:
            return .requestParameters(parameters: ["type": "REACTED"], encoding: URLEncoding.queryString)
        case .popularityPostList:
            return .requestParameters(parameters: ["sort": "POPULAR"], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .createPost(_, let authorization), .uploadImage(_, let authorization), .allUserList(let authorization), .myPostList(let authorization), .myReactionPostList(let authorization), .popularityPostList(let authorization), .popularityUserList(let authorization):
            return ["Authorization": "Bearer \(authorization)"]
        }
    }
}
