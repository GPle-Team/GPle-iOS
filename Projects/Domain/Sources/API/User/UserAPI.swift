import Foundation
import Moya

public enum UserAPI {
    case userInfoInput(authorization: String)
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .userInfoInput:
            return "/User/profile"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .userInfoInput:
            return .get
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
            switch self {
            case .userInfoInput:
                return .requestPlain
            }
        }

        public var headers: [String : String]? {
            switch self {
            case .userInfoInput(let authorization):
                return ["Authorization": authorization]
            }
        }
}
