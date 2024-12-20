import UIKit
import Moya
import Domain
import Foundation

public final class PostViewModel: ObservableObject {
    private let authProvider = MoyaProvider<PostAPI>()
    private var title: String = ""
    private var accessToken: String = "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzM0NjYyNTg4LCJleHAiOjE3NDQ2NjI1ODh9.FG4FVQ4oikC4HNy5h7gq0QyCIjVZtceIOKwAMnkULAt4y0lX5gGIF1s2Mdj9qr1H"
    private var userList: [Int] = []
    private var imageUrl: [String] = []
    private var imageUrlString: [String] = []
    private var image: [UIImage] = []
    private var location: String = ""
    private var imageDataArray: [Data] = []
    @Published public var allUserList: [UserListResponse] = []
    @Published var myPostList: [MyPostListResponse] = []
    @Published var myReactionPostList: [MyReactionPostListResponse] = []
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

    public func myReactionPostList(completion: @escaping (Bool) -> Void) {
        authProvider.request(.myReactionPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(response):
                do {
                    let decodedResponse = try JSONDecoder().decode([MyReactionPostListResponse].self, from: response.data)
                    self.myReactionPostList = decodedResponse
                    print("성공: 내 게시물 리스트 불러오기")
                    print("불러온 게시물 목록:")
                    for (index, post) in decodedResponse.enumerated() {
                        print("게시물 \(index + 1):")
                        print("  ID: \(post.id)")
                        print("  작성자: \(post.author.name)")
                        print("  학년: \(post.author.grade)")
                        print("  제목: \(post.title)")
                        print("  위치: \(post.location)")
                        print("  이미지 URL: \(post.imageUrl)")
                        print("  태그된 사용자:")
                        for user in post.tagList {
                            print("    - \(user.name) (ID: \(user.id))")
                        }
                        print("  이모지 반응:")
                        print("    하트: \(post.emojiList.heartCount)")
                        print("    축하: \(post.emojiList.congCount)")
                        print("    엄지: \(post.emojiList.thumbsCount)")
                        print("    생각: \(post.emojiList.thinkCount)")
                        print("    똥: \(post.emojiList.poopCount)")
                        print("    중국: \(post.emojiList.chinaCount)")
                        print("  생성 시간: \(post.createdTime)")
                        print("--------------------")
                    }
                    completion(true)
                } catch {
                    print("JSON 디코딩 실패: \(error)")
                    completion(false)
                }
            case let .failure(err):
                print("네트워크 요청 실패: \(err)")
                completion(false)
            }
        }
    }


    public func myPostList(completion: @escaping (Bool) -> Void) {
            authProvider.request(.myPostList(authorization: accessToken)) { result in
                switch result {
                case let .success(response):
                    do {
                        // JSON 데이터를 디코딩하여 myPostList에 저장
                        let decodedResponse = try JSONDecoder().decode([MyPostListResponse].self, from: response.data)
                        self.myPostList = decodedResponse

                        // 디버깅 로그 출력: 데이터를 확인
                        //print("데이터가 잘 저장되었습니다: \(self.myPostList[0])")

                        // 각 게시물의 ID와 위치를 출력
                        for post in decodedResponse {
                            print("게시물 ID: \(post.id), 위치: \(post.location)")
                            print("이미지: \(post.imageUrl[0])")
                        }

                        completion(true)
                    } catch {
                        print("JSON 디코딩 실패: \(error)")
                        completion(false)
                    }
                case let .failure(err):
                    print("네트워크 요청 실패: \(err)")
                    completion(false)
                }
            }
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
