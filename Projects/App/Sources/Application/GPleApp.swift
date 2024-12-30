import SwiftUI

@main
struct GoogleSignInProjectApp: App {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    @StateObject var userInfoViewModel: UserInfoViewModel = UserInfoViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel(), userInfoViewModel: userInfoViewModel)
        }
    }
}
