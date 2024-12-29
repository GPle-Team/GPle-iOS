import Foundation
import Combine
import Moya
import Domain

final class UserInfoViewModel: ObservableObject {
    // 입력된 사용자 정보
    @Published var name: String = ""
    @Published var number: String = ""

    // 네트워크 요청 상태를 나타내는 퍼블리셔
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // Moya 프로바이더 초기화
    private let provider = MoyaProvider<UserAPI>()

    private func fetchAccessToken() -> String? {
        return KeyChain.shared.read(key: Const.KeyChainKey.accessToken)
    }
    
    // 사용자 정보 제출 함수
    func submitUserInfo() {
        // 로딩 상태 시작
        isLoading = true
        errorMessage = nil
        print("name: \(name), number: \(number)")
        
        // 인증 토큰 (실제 앱에서는 안전한 저장소에서 가져와야 함)
        guard let authorizationToken = fetchAccessToken() else { return }

        // API 호출
        provider.request(.userInfoInput(authorization: authorizationToken, name: name, number: number, file: nil)) { [weak self] result in
            // 로딩 상태 종료
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            switch result {
            case .success(let response):
                // 서버 응답 처리
                if (200...299).contains(response.statusCode) {
                    // 성공 처리
                    print("사용자 정보가 성공적으로 전송되었습니다.")
                } else {
                    // 서버 오류 메시지 처리
                    DispatchQueue.main.async {
                        self?.errorMessage = "서버 오류: \(response.statusCode)"
                    }
                }
            case .failure(let error):
                // 네트워크 오류 처리
                DispatchQueue.main.async {
                    self?.errorMessage = "네트워크 오류: \(error.localizedDescription)"
                }
            }
        }
    }
}
