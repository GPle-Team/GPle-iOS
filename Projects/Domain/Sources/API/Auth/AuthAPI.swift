import Foundation
import Moya

public enum AuthAPI {
    case login(idToken: String)
    case logout
    case refresh
}

extension AuthAPI: GPleAPI {
    public var domain: GPleDomain {
        .auth
    }
    
    public var urlPath: String {
        switch self {
        case .login:
            return "/google/login"
        case .logout:
            return "/logout"
        case .refresh:
            return "/"
        }
    }
    
    public var jwtTokenType: JwtTokenType {
        switch self {
        case .login, .refresh:
            return .refreshToken
            
        case .logout:
            return .accessToken
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
        case let .login(code):
            return .requestParameters(parameters: [
                    "code" : code
                ],
                encoding: JSONEncoding.default)
        case .logout, .refresh:
            return .requestPlain
        }
    }
}
