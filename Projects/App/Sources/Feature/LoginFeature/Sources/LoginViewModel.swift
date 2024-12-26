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

            print("ID Token: \(idToken)")
            self?.sendIdTokenToServer(idToken)
        }
    }

    private func sendIdTokenToServer(_ idToken: String) {
        provider.request(.login(idToken: idToken)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    if let responseData = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        print("Response: \(responseData)")
                        DispatchQueue.main.async {
                            self?.isSignedIn = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.errorMessage = "Unexpected response format."
                        }
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
