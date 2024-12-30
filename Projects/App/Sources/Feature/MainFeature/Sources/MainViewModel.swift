import Moya
import Domain
import Foundation

public final class MainViewModel: ObservableObject {
    private let authProvider = MoyaProvider<MainAPI>()
    private var accessToken: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""

    @Published public var allPostList: [Post] = []
    @Published public var gymPostList: [Post] = []
    @Published public var homePostList: [Post] = []
    @Published public var playgroundPostList: [Post] = []
    @Published public var domitoryPostList: [Post] = []
    @Published public var walkingTrailPostList: [Post] = []
    @Published var selectedIndices: [String: Int] = [:]

    @MainActor
    public func fetchAllPostList() {
        authProvider.request(.fetchAllPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }
                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.allPostList = responseModel
                    print("성공ㅣ전체 게시물 불러오기")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
        
//        self.allPostList = fetchPostsFromServer()
//        self.selectedIndices = Dictionary(uniqueKeysWithValues: allPostList.map { ($0.id, 0) })
    }
    
//    private func fetchPostsFromServer() -> [Post] {
//            // 서버에서 게시글 목록 가져오기 (예제)
//            return [
//                Post(id: "1", title: "Post 1", location: "Location 1", author: Author(name: "Author 1", grade: 1), imageUrl: ["https://example.com/image1.jpg"], tagList: [], emojiList: EmojiList(), checkEmoji: [], createdTime: "2024-12-31T00:00:00"),
//                Post(id: "2", title: "Post 2", location: "Location 2", author: Author(name: "Author 2", grade: 2), imageUrl: ["https://example.com/image2.jpg"], tagList: [], emojiList: EmojiList(), checkEmoji: [], createdTime: "2024-12-31T00:00:00"),
//            ]
//        }
}
