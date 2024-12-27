import Moya
import Domain
import Foundation

final class LocationPostViewModel: ObservableObject {
    private let authProvider = MoyaProvider<MainAPI>()
    private var accessToken: String = "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiIyIiwiaWF0IjoxNzM0NjYyNTg4LCJleHAiOjE3NDQ2NjI1ODh9.FG4FVQ4oikC4HNy5h7gq0QyCIjVZtceIOKwAMnkULAt4y0lX5gGIF1s2Mdj9qr1H"

    @Published public var gymPostList: [Post] = []
    @Published public var homePostList: [Post] = []
    @Published public var playgroundPostList: [Post] = []
    @Published public var domitoryPostList: [Post] = []
    @Published public var walkingTrailPostList: [Post] = []

    @MainActor
    public func fetchPostListByLocation(type: String) {
        authProvider.request(.fetchPostListByLocation(type: type, authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)

                    switch type {
                    case "GYM":
                        self.gymPostList = responseModel
                    case "HOME":
                        self.homePostList = responseModel
                    case "PLAYGROUND":
                        self.playgroundPostList = responseModel
                    case "DOMITORY":
                        self.domitoryPostList = responseModel
                    case "WALKING_TRAIL":
                        self.walkingTrailPostList = responseModel
                    default:
                        break
                    }
                    print("\(type) 게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
}
