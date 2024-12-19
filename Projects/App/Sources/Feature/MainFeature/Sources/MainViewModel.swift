import Moya
import Domain
import Foundation

public final class MainViewModel: ObservableObject {
    private let authProvider = MoyaProvider<MainAPI>()
    private var accessToken: String = "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzM0NTA2MDY0LCJleHAiOjE3NDQ1MDYwNjR9.4LAh6fTEeGxyaakWqe5AFQZInrWvPR-4oYZfQiZmne_34UwBTSm9i22QXyxwHeYA"
    
    @Published public var allPostList: [FetchAllPostListResponse.Post] = []

    @MainActor
    public func fetchAllPostList() {
        authProvider.request(.fetchAllPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    let responseModel = try JSONDecoder().decode(FetchAllPostListResponse.self, from: res.data)
                    self.allPostList = responseModel.posts
                    print("성공ㅣ전체 게시물 불러오기")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
}
