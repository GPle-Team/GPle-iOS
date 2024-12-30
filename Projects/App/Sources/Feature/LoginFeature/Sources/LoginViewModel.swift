import Foundation
import GoogleSignIn
import Moya
import Domain

final class LoginViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String?
    
    private let provider = MoyaProvider<AuthAPI>()

    private func getGoogleClientID() -> String? {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let clientID = plist["CLIENT_ID"] as? String else {
            print("Unable to fetch Google Client ID from GoogleService-Info.plist")
            return nil
        }
        return clientID
    }

    @MainActor
    func signIn() {
        guard let clientID = getGoogleClientID() else {
            print("Google Client ID is missing.")
            return
        }
        

        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = "Sign-in error: \(error.localizedDescription)"
                }
                return
            }

            guard let idToken = result?.user.idToken?.tokenString else {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to retrieve ID Token."
                }
                return
            }

            print("CILENT_ID: \(clientID)")
            print("ID Token: \(idToken)")
            self?.sendIdTokenToServer(idToken)
        }
    }

    @MainActor
    private func sendIdTokenToServer(_ idToken: String) {
        provider.request(.login(idToken: idToken)) { [weak self] result in
            switch result {
            case let .success(res):
                do {
                    
                    let loginResponse = try JSONDecoder().decode(Token.self, from: res.data)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                    if let accessTokenExpirationDate = dateFormatter.date(from: loginResponse.accessExpiredAt),
                       let refreshTokenExpirationDate = dateFormatter.date(from: loginResponse.refreshExpiredAt) {

                        let accessTokenExpirationInterval = accessTokenExpirationDate.timeIntervalSinceNow
                        let refreshTokenExpirationInterval = refreshTokenExpirationDate.timeIntervalSinceNow

                        KeyChain.shared.saveTokenWithExpiration(
                            key: Const.KeyChainKey.accessToken,
                            token: loginResponse.accessToken,
                            expiresIn: accessTokenExpirationInterval
                        )

                        KeyChain.shared.saveTokenWithExpiration(
                            key: Const.KeyChainKey.refreshToken,
                            token: loginResponse.refreshToken,
                            expiresIn: refreshTokenExpirationInterval
                        )

                        print("Access Token 만료 날짜: \(accessTokenExpirationDate)")
                        print("Refresh Token 만료 날짜: \(refreshTokenExpirationDate)")
                        print("토큰 저장 완료")
                    } else {
                        print("만료 시간 변환 오류: 유효한 날짜 형식이 아님.")
                    }
                    print("------------------------------------------------------------")
                    
                    DispatchQueue.main.async {
                        print("Access Token: \(loginResponse.accessToken)")
                        print("Refresh Token: \(loginResponse.refreshToken)")
                        print("Access Token Expiry: \(loginResponse.accessExpiredAt)")
                        print("Refresh Token Expiry: \(loginResponse.refreshExpiredAt)")
                        self?.isSignedIn = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.errorMessage = "Failed to parse response: \(error.localizedDescription)"
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Request failed: \(error.localizedDescription)"
                }
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        DispatchQueue.main.async {
            self.isSignedIn = false
        }
    }
}
