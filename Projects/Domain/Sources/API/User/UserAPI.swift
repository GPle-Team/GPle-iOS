//import Foundation
//import Moya
//
//public enum UserAPI {
//    case userInfoInput(authorization: String, name: String, number: String, file: Data)
//}
//
//extension UserAPI: TargetType {
//    public var baseURL: URL {
//        return URL(string: "https://port-0-gple-backend-eg4e2alkoplc4q.sel4.cloudtype.app")!
//    }
//
//    public var path: String {
//        switch self {
//        case .userInfoInput:
//            return "/profile"
//        }
//    }
//
//    public var method: Moya.Method {
//        switch self {
//        case .userInfoInput:
//            return .post
//        }
//    }
//
//    public var sampleData: Data {
//        return "{}".data(using: .utf8)!
//    }
//
//    public var task: Task {
//            switch self {
//            case .userInfoInput(let authorization, let name, let number, let file):
//                // Form data (name, number) and file upload using multipart
//                return .requestCompositeParameters(
//                    bodyParameters: [
//                        "name": name,
//                        "number": number
//                    ],
//                    bodyEncoding: JSONEncoding.default, // Form data with JSON encoding
//                    urlParameters: [:], // No URL parameters
//                    multipartBody: [
//                        MultipartFormData(provider: .data(file), name: "file", fileName: "profile_image.jpg", mimeType: "image/jpeg")
//                    ]
//                )
//            }
//        }
//
//        public var headers: [String : String]? {
//            switch self {
//            case .userInfoInput(let authorization, _, _, _):
//                return [
//                    "Authorization": "Bearer \(authorization)", // Authorization token
//                    "Content-Type": "multipart/form-data" // Set content type for multipart requests
//                ]
//            }
//        }
//}
