import Foundation
import GoogleSignIn
import Moya
import Domain

class LoginViewModel: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var errorMessage: String?

    private let provider = MoyaProvider<AuthAPI>()

    func signIn() {
        guard let clientID = ProcessInfo.processInfo.environment["GOOGLE_CLIENT_ID"] else {
            print("Google Client ID is missing.")
            return
        }

        let configuration = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return }

        // Google Sign-In 시작
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Sign-in error: \(error.localizedDescription)"
                return
            }

            // ID Token 가져오기
            guard let idToken = result?.user.idToken?.tokenString else {
                self?.errorMessage = "Failed to retrieve ID Token."
                return
            }

            // 서버로 ID Token 전송
            self?.sendIdTokenToServer(idToken)
        }
    }

    private func sendIdTokenToServer(_ idToken: String) {
        provider.request(.login(idToken: idToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let responseData = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]
                    print("Response: \(String(describing: responseData))")
                    self?.isSignedIn = true
                } catch {
                    self?.errorMessage = "Failed to parse response: \(error.localizedDescription)"
                }
            case .failure(let error):
                self?.errorMessage = "Request failed: \(error.localizedDescription)"
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        isSignedIn = false
    }
}
