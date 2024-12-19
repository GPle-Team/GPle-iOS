import Foundation
import Moya

public enum MainAPI {
    case fetchAllPostList(authorization: String)
}

extension MainAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://active-weasel-fluent.ngrok-free.app")!
    }

    public var path: String {
        switch self {
        case .fetchAllPostList:
            return "/post"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetchAllPostList:
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
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .fetchAllPostList(let authorization):
            return ["Authorization": authorization]
        }
    }
}
