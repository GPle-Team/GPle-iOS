import UIKit
import Moya
import Domain
import Foundation

public final class PostViewModel: ObservableObject {
    private let authProvider = MoyaProvider<PostAPI>()

    private var title: String = ""
    private var accessToken: String = "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzM0NTA2MDY0LCJleHAiOjE3NDQ1MDYwNjR9.4LAh6fTEeGxyaakWqe5AFQZInrWvPR-4oYZfQiZmne_34UwBTSm9i22QXyxwHeYA"
    private var userList: [Int64] = []
    private var imageUrl: [String] = []
    private var image: [UIImage] = []
    private var location: String = ""
    private var imageDataArray: [Data] = []

    func setupTitle(title: String) {
        self.title = title
    }

    func setupUserList(userList: [Int64]) {
        self.userList = userList
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

    func uploadImages() {
        authProvider.request(.uploadImage(files: imageDataArray, authorization: accessToken)) { result in
            switch result {
            case .success(let response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    let uploadResponse = try JSONDecoder().decode(ImageUploadResponse.self, from: response.data)
                    let uploadedUrls = uploadResponse.urls
                    print("성공ㅣ이미지 업로드")
                    print("업로드 URL: \(uploadedUrls)")

                } catch {
                    let statusCode = response.statusCode
                    if let responseData = String(data: response.data, encoding: .utf8) {
                        print("실패ㅣ이미지 업로드 - 상태 코드: \(statusCode)")
                        print("응답 데이터: \(responseData)")
                    } else {
                        print("실패ㅣ이미지 업로드 - 상태 코드: \(statusCode), 응답 데이터 없음")
                    }
                }

            case .failure(let error):
                print("네트워크 요청 실패: \(error.localizedDescription)")
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
