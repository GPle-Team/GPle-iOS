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
    private var location: String = ""

    func setupTitle(title: String) {
        self.title = title
    }

    func setupUserList(userList: [Int64]) {
        self.userList = userList
    }

    func setupImageUrl(imageUrl: [String]) {
        self.imageUrl = imageUrl
    }

    func setupLocation(location: String) {
        self.location = location
    }

    
}
