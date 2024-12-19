import SwiftUI

struct MineView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Text("로그인 완료!")
        
        Button {
            loginViewModel.signOut()
        } label: {
            Text("로그아웃")
        }

    }
}
