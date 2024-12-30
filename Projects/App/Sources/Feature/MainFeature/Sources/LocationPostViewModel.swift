import Moya
import Domain
import Foundation

final class LocationPostViewModel: ObservableObject {
    private let authProvider = MoyaProvider<MainAPI>()
    private var accessToken: String = UserDefaults.standard.string(forKey: "accessToken") ?? ""

    @Published public var gymPostList: [Post] = []
    @Published public var homePostList: [Post] = []
    @Published public var playgroundPostList: [Post] = []
    @Published public var domitoryPostList: [Post] = []
    @Published public var walkingTrailPostList: [Post] = []

    @MainActor
    public func fetchGymList() {
        authProvider.request(.fetchGymPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.gymPostList = responseModel
                    
                    print("게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
    
    @MainActor
    public func fetchHomeList() {
        authProvider.request(.fetchHomePostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.homePostList = responseModel
                    
                    print("게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
    
    @MainActor
    public func fetchPlayGroundList() {
        authProvider.request(.fetchPlaygroundPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.playgroundPostList = responseModel
                    
                    print("게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
    
    @MainActor
    public func fetchDomitoryList() {
        authProvider.request(.fetchDomitoryPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.domitoryPostList = responseModel
                    
                    print("게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
    
    @MainActor
    public func fetchWalkingTrailList() {
        authProvider.request(.fetchWalkingTrailPostList(authorization: accessToken)) { result in
            switch result {
            case let .success(res):
                do {
                    if let responseString = String(data: res.data, encoding: .utf8) {
                        print("서버 응답 데이터: \(responseString)")
                    }

                    let responseModel = try JSONDecoder().decode([Post].self, from: res.data)
                    self.walkingTrailPostList = responseModel
                    
                    print("게시물 불러오기 성공")
                } catch {
                    print("JSON 디코딩 에러: \(error)")
                }
            case let .failure(err):
                print("Network request failed: \(err)")
            }
        }
    }
}
