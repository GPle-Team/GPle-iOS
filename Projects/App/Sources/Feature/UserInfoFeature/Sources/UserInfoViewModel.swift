import Foundation
import Combine
import Moya
import Domain

final class UserInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var number: String = ""

    @Published var errorMessage: String? = nil

    private let provider = MoyaProvider<UserAPI>()

    private func fetchAccessToken() -> String? {
        return KeyChain.shared.read(key: Const.KeyChainKey.accessToken)
    }
    
    func submitUserInfo() {
        errorMessage = nil
        print("name: \(name), number: \(number)")
        
        guard let authorizationToken = fetchAccessToken() else { return }

        provider.request(.userInfoInput(authorization: authorizationToken, name: name, number: number, file: nil)) { [weak self] result in
            print("요청 전달")
            
            switch result {
            case .success(let response):
                if (200...299).contains(response.statusCode) {
                    print("사용자 정보가 성공적으로 전송되었습니다.")
                } else {
                    DispatchQueue.main.async {
                        self?.errorMessage = "서버 오류: \(response.statusCode)"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                }
            }
        }
    }
}
