import Foundation
import Moya

public enum MainAPI {
    case fetchAllPostList(authorization: String)
    case fetchGymPostList(authorization: String)
    case fetchPlaygroundPostList(authorization: String)
    case fetchDomitoryPostList(authorization: String)
    case fetchHomePostList(authorization: String)
    case fetchWalkingTrailPostList(authorization: String)
}

extension MainAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .fetchAllPostList, .fetchGymPostList, .fetchDomitoryPostList, .fetchHomePostList, .fetchPlaygroundPostList, .fetchWalkingTrailPostList:
            return "/post"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .fetchAllPostList, .fetchGymPostList, .fetchDomitoryPostList, .fetchHomePostList, .fetchPlaygroundPostList, .fetchWalkingTrailPostList:
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
        case .fetchGymPostList(authorization: let authorization):
            return .requestParameters(parameters: ["location" : "GYM"], encoding: URLEncoding.queryString)
        case .fetchPlaygroundPostList(authorization: let authorization):
            return .requestParameters(parameters: ["location" : "PLAYGROUND"], encoding: URLEncoding.queryString)
        case .fetchDomitoryPostList(authorization: let authorization):
            return .requestParameters(parameters: ["location" : "DOMITORY"], encoding: URLEncoding.queryString)
        case .fetchHomePostList(authorization: let authorization):
            return .requestParameters(parameters: ["location" : "HOME"], encoding: URLEncoding.queryString)
        case .fetchWalkingTrailPostList(authorization: let authorization):
            return .requestParameters(parameters: ["location" : "WALKING_TRAIL"], encoding: URLEncoding.queryString)
        }
    }

    public var headers: [String : String]? {
        switch self {
        case .fetchAllPostList(let authorization), .fetchGymPostList(let authorization), .fetchPlaygroundPostList(let authorization), .fetchDomitoryPostList(let authorization), .fetchHomePostList(let authorization), .fetchWalkingTrailPostList(let authorization):
            return ["Authorization": "Bearer \(authorization)"]
        }
    }
}
