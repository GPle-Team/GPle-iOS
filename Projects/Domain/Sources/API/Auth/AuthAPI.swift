import Foundation
import Moya

public enum AuthAPI {
    case login(idToken: String)
    case logout(refreshToken: String)
    case refresh(idToken: String)
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/auth/google/token"
        case .logout:
            return "/auth/logout"
        case .refresh:
            return "/auth/"
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
        case let .login(idToken), let .refresh(idToken):
            return .requestParameters(parameters: [
                "idToken" : idToken
                ],
                encoding: JSONEncoding.default)
        case .logout:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case
            .logout(let refreshToken):
            return ["Content-Type": "application/json", "refreshToken": refreshToken]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
