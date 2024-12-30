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
            self?.sendIdTokenToServer(idToken) { success in
                if success {
                    print("토큰 저장 성공!")
                } else {
                    print("토큰 저장 실패.")
                }
            }

        }
    }

    public func sendIdTokenToServer(_ idToken: String, completion: @escaping (Bool) -> Void) {
        provider.request(.login(idToken: idToken)) { [weak self] result in
            switch result {
            case let .success(res):
                do {
                    let loginResponse = try JSONDecoder().decode(Token.self, from: res.data)

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

                    let accessTokenExpirationDate = dateFormatter.date(from: loginResponse.accessExpiredAt)
                    let refreshTokenExpirationDate = dateFormatter.date(from: loginResponse.refreshExpiredAt)

                    if accessTokenExpirationDate == nil {
                        print("Access Token 만료 시간 변환 실패: 형식이 맞지 않음, 기본 값으로 처리됨.")
                    }
                    if refreshTokenExpirationDate == nil {
                        print("Refresh Token 만료 시간 변환 실패: 형식이 맞지 않음, 기본 값으로 처리됨.")
                    }

                    let accessTokenExpirationInterval = accessTokenExpirationDate?.timeIntervalSinceNow ?? 0
                    let refreshTokenExpirationInterval = refreshTokenExpirationDate?.timeIntervalSinceNow ?? 0

                    UserDefaults.standard.set(loginResponse.accessToken, forKey: "accessToken")
                    UserDefaults.standard.set(loginResponse.refreshToken, forKey: "refreshToken")

                    if let savedAccessToken = UserDefaults.standard.string(forKey: "accessToken") {
                        print("Access Token 저장 완료: \(savedAccessToken)")
                    } else {
                        print("Access Token 저장 실패")
                    }

                    if let savedRefreshToken = UserDefaults.standard.string(forKey: "refreshToken") {
                        print("Refresh Token 저장 완료: \(savedRefreshToken)")
                    } else {
                        print("Refresh Token 저장 실패")
                    }

                    print("Access Token 만료 날짜: \(accessTokenExpirationDate ?? Date())")
                    print("Refresh Token 만료 날짜: \(refreshTokenExpirationDate ?? Date())")
                    print("토큰 저장 완료")

                    DispatchQueue.main.async {
                        self?.isSignedIn = true
                    }

                    completion(true)

                } catch {
                    DispatchQueue.main.async {
                        self?.errorMessage = "Failed to parse response: \(error.localizedDescription)"
                    }
                    
                    completion(false)
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Request failed: \(error.localizedDescription)"
                }

                completion(false)
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
