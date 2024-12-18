import SwiftUI

struct MineView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Text("로그인 완료!")
        
        Button {
            authenticationViewModel.signOut()
        } label: {
            Text("로그아웃")
        }

    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView()
            .environmentObject(AuthenticationViewModel())
    }
}
