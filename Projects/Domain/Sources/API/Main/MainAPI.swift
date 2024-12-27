import Foundation
import Moya

public enum MainAPI {
    case fetchAllPostList(authorization: String)
    case fetchPostListByLocation(type: String, authorization: String)
}

extension MainAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .fetchAllPostList:
            return "/post"
        case .fetchPostListByLocation:
            return "/post/location"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetchAllPostList, .fetchPostListByLocation:
            return .get
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
            case .fetchAllPostList:
                return .requestPlain
            case .fetchPostListByLocation(let type, let authorization):
                return .requestParameters(parameters: ["type": type], encoding: URLEncoding.default)
            }
    }

    public var headers: [String : String]? {
        switch self {
        case .fetchAllPostList(let authorization),
                .fetchPostListByLocation(_, let authorization):
            return ["Authorization": authorization]
        }
    }
}
