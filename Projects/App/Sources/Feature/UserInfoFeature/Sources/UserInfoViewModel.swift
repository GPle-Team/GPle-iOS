import Foundation
import Combine
import Moya
import Domain

final class UserInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var number: String = ""
    @Published var errorMessage: String? = nil

    private let provider = MoyaProvider<UserAPI>()

    func submitUserInfo(completion: @escaping (Bool) -> Void) {
        errorMessage = nil
        print("name: \(name), number: \(number)")

        if let tokenData = UserDefaults.standard.string(forKey: "accessToken") {
            print("Token found: \(tokenData)")

            provider.request(.userInfoInput(authorization: tokenData, name: name, number: number, file: nil)) { [weak self] result in
                print("요청 전달")

                switch result {
                case .success(let response):
                    print("응답 상태 코드: \(response.statusCode)")
                    if let responseBody = String(data: response.data, encoding: .utf8) {
                        print("응답 본문: \(responseBody)")
                    }

                    if (200...299).contains(response.statusCode) {
                        print("사용자 정보가 성공적으로 전송되었습니다.")
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.errorMessage = "서버 오류: \(response.statusCode)"
                        }

                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                case .failure(let error):
                    print("네트워크 오류: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self?.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                    }

                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
            }
        } else {
            print("토큰이 없거나 만료되었습니다.")
            self.errorMessage = "유효한 토큰이 없습니다."

            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
