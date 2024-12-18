import UIKit
import Moya
import Domain
import Foundation

public final class PostViewModel: ObservableObject {
    private let authProvider = MoyaProvider<PostAPI>()
    private var title: String = ""
    private var accessToken: String = "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzM0NTA2MDY0LCJleHAiOjE3NDQ1MDYwNjR9.4LAh6fTEeGxyaakWqe5AFQZInrWvPR-4oYZfQiZmne_34UwBTSm9i22QXyxwHeYA"
    private var userList: [Int] = []
    private var imageUrl: [String] = []
    private var imageUrlString: [String] = []
    private var image: [UIImage] = []
    private var location: String = ""
    private var imageDataArray: [Data] = []
    @Published public var allUserList: [UserListResponse] = []
    private var imageUploadResponse: ImageUploadResponse?

    func setupTitle(title: String) {
        self.title = title
    }

    func setupUserList(userList: [Int]) {
        self.userList = userList
    }

    func setupImageUrlString(imageUrlString: [String]) {
        self.imageUrlString = imageUrlString
    }

    func setupImageUrl(imageUrl: [String]) {
        self.imageUrl = imageUrl
    }

    func setupImage(images: [UIImage]) {
        self.imageDataArray = images.compactMap { $0.jpegData(compressionQuality: 0.5) }
    }

    func setupLocation(location: String) {
        self.location = location
    }

    public func allUserList(completion: @escaping (Bool) -> Void) {
        authProvider.request(.allUserList(authorization: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    print("성공ㅣ유저 리스트 불러오기")
                    self.allUserList = try JSONDecoder().decode([UserListResponse].self, from: response.data)
                    completion(true)
                } catch {
                    print("Failed to decode JSON response")
                    completion(false)
                }
            case let .failure(err):
                print("Network request failed: \(err)")
                completion(false)
            }
        }
    }


    public func uploadImages(completion: @escaping (Bool) -> Void) {
        authProvider.request(.uploadImage(files: imageDataArray, authorization: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    let uploadResponse = try JSONDecoder().decode(ImageUploadResponse.self, from: response.data)
                    let uploadedUrls = uploadResponse.urls

                    self.imageUploadResponse = uploadResponse

                    print("성공ㅣ이미지 업로드")
                    print("업로드 URL: \(uploadedUrls)")
                    completion(true)
                } catch {
                    let statusCode = response.statusCode
                    if let responseData = String(data: response.data, encoding: .utf8) {
                        print("실패ㅣ이미지 업로드 - 상태 코드: \(statusCode)")
                        print("응답 데이터: \(responseData)")
                    } else {
                        print("실패ㅣ이미지 업로드 - 상태 코드: \(statusCode), 응답 데이터 없음")
                    }
                    completion(false)
                }

            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
                completion(false)
                if let response = error.response {
                    let statusCode = response.statusCode
                    if let responseData = String(data: response.data, encoding: .utf8) {
                        print("실패ㅣ상태 코드: \(statusCode)")
                        print("오류ㅣ응답 데이터: \(responseData)")
                    } else {
                        print("오류ㅣ상태 코드: \(statusCode), 오류 응답 데이터 없음")
                    }
                }
            }
        }
    }

    public func createPost(completion: @escaping (Bool) -> Void) {

        guard let imageUrls = imageUploadResponse?.urls else {
            print("이미지 URL이 없습니다.")
            completion(false)
            return
        }

        let postRequest = CreatePostRequest(
            title: title,
            location: location,
            userList: userList,
            imageUrl: imageUrls
        )

        authProvider.request(.createPost(param: postRequest, authorization: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    print("게시물 생성 완료")
                    completion(true)
                } catch {
                    let statusCode = response.statusCode
                    if let responseData = String(data: response.data, encoding: .utf8) {
                        print("실패ㅣ게시물 생성 - 상태 코드: \(statusCode)")
                        print("응답 데이터: \(responseData)")
                    } else {
                        print("실패ㅣ게시물 생성 - 상태 코드: \(statusCode), 응답 데이터 없음")
                    }
                    completion(false)
                }

            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
                completion(false)
                if let response = error.response {
                    let statusCode = response.statusCode
                    if let responseData = String(data: response.data, encoding: .utf8) {
                        print("실패ㅣ상태 코드: \(statusCode)")
                        print("오류ㅣ응답 데이터: \(responseData)")
                    } else {
                        print("오류ㅣ상태 코드: \(statusCode), 오류 응답 데이터 없음")
                    }
                }
            }
        }
    }
}
