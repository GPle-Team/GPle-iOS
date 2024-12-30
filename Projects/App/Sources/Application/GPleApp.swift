import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct GoogleSignInProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    @StateObject var userInfoViewModel: UserInfoViewModel = UserInfoViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(), userInfoViewModel: userInfoViewModel)
        }
    }
}
