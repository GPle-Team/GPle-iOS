import Moya
import Foundation

public protocol GPleAPI: TargetType, JwtAuthorizable {
    associatedtype ErrorType: Error
    var domain: GPleDomain { get }
    var urlPath: String { get }
    var errorMap: [Int: ErrorType] { get }
}

public extension GPleAPI {
    var baseURL: URL {
        URL(
            string: Bundle.module.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        ) ?? URL(string: "https://www.google.com")!
    }

    var path: String {
        domain.asURLString + urlPath
    }

    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}

public enum GPleDomain: String {
    case auth
}

extension GPleDomain {
    var asURLString: String {
        "\(self.rawValue)"
    }
}

private class BundleFinder {}

extension Foundation.Bundle {
    static let module = Bundle(for: BundleFinder.self)
}
