import Foundation
import Moya

public enum MainAPI {
    case fetchAllPostList(authorization: String)
    case fetchGym(authorization: String)
    case fetchHome(authorization: String)
    case fetchPlayGround(authorization: String)
    case fetchDomitory(authorization: String)
    case fetchWalkingTrail(authorization: String)
}

extension MainAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .fetchAllPostList:
            return "/post"
        case .fetchGym, .fetchHome, .fetchPlayGround, .fetchDomitory, .fetchWalkingTrail:
            return "/post/location?type"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetchAllPostList, .fetchGym, .fetchHome, .fetchPlayGround, .fetchDomitory, .fetchWalkingTrail:
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
            case .fetchGym, .fetchHome, .fetchPlayGround, .fetchDomitory, .fetchWalkingTrail:
                return .requestParameters(parameters: ["type": getLocationType()], encoding: URLEncoding.default)
            }
    }

    public var headers: [String : String]? {
        switch self {
        case .fetchAllPostList(let authorization),
                .fetchGym(let authorization),
                .fetchHome(let authorization),
                .fetchPlayGround(let authorization),
                .fetchDomitory(let authorization),
                .fetchWalkingTrail(let authorization):
            return ["Authorization": authorization]
        }
    }
    
    private func getLocationType() -> String {
            switch self {
            case .fetchGym:
                return "금봉관"
            case .fetchHome:
                return "본관"
            case .fetchPlayGround:
                return "운동장"
            case .fetchDomitory:
                return "동행관"
            case .fetchWalkingTrail:
                return "산책로"
            case .fetchAllPostList:
                return ""
            }
        }
}
