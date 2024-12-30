import Foundation
import Moya

public enum EmojiAPI {
    case emojiPost(param: EmojiRequest, authorization: String)
}

extension EmojiAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .emojiPost:
            return "/emoji"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .emojiPost:
            return .post
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .emojiPost(let param, _):
            return .requestJSONEncodable(param)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .emojiPost(_, let authorization):
            return ["Authorization": "Bearer \(authorization)"]
        }
    }
}
