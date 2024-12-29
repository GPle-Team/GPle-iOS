import Foundation
import Moya

public enum UserAPI {
    case userInfoInput(authorization: String, name: String, number: String, file: Data?)
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .userInfoInput:
            return "/user/profile"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .userInfoInput:
            return .post
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
            switch self {
            case let .userInfoInput(authorization, name, number, file):
                // Form data (name, number) and file upload using multipart
                var formData: [MultipartFormData] = [
                    MultipartFormData(provider: .data(name.data(using: .utf8)!), name: "name"),
                    MultipartFormData(provider: .data(number.data(using: .utf8)!), name: "number")
                ]
                
                // 이미지가 존재하면 추가
                if let fileData = file {
                    let fileFormData = MultipartFormData(provider: .data(fileData), name: "image", fileName: "profile_image.jpg", mimeType: "image/jpeg")
                    formData.append(fileFormData)
                }
                
                return .uploadMultipart(formData)
            }
        }

        public var headers: [String : String]? {
            switch self {
            case .userInfoInput(let authorization, _, _, _):
                return [
                    "Authorization": "Bearer \(authorization)", // Authorization token
                    "Content-Type": "multipart/form-data" // Set content type for multipart requests
                ]
            }
        }
}
