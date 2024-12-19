import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            if loginViewModel.signState == .signIn {
                MineView()
            } else {
                LoginView()
            }
        }
        .padding()
    }
}
