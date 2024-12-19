import Foundation
import Moya

public enum AuthAPI {
    case login(code: String, authorization: String)
    case logout(authorization: String)
    case refresh(authorization: String)
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://active-weasel-fluent.ngrok-free.app")!
    }

    public var path: String {
        switch self {
        case .login:
            return "/google/login"
        case .logout:
            return "/logout"
        case .refresh:
            return "/"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .login, .logout:
            return .post
        case .refresh:
            return .patch
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case let .login(code, _):
            return .requestParameters(parameters: [
                    "code" : code
                ],
                encoding: JSONEncoding.default)
        case .logout(_), .refresh(_):
            return .requestPlain
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .login(_, let authorization), .logout(let authorization), .refresh(let authorization):
            return ["Authorization": authorization]
        }
    }
}
