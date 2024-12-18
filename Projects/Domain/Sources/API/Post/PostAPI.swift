import Foundation
import Moya

public enum PostAPI {
    case createPost(param: CreatePostRequest, authorization: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://active-weasel-fluent.ngrok-free.app")!
    }

    public var path: String {
        switch self {
        case .createPost:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .createPost:
            return .post
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .createPost(let param, _):
            return .requestJSONEncodable(param)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .createPost(_, let authorization):
            return ["Content-Type": "application/json", "Authorization": authorization]
        }
    }
}
