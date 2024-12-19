import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        VStack {
            Button {
                loginViewModel.signIn()
            } label: {
                Text("Google Account Login")
            }

        }
    }
}
