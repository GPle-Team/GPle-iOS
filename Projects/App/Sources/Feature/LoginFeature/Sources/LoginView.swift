import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    @StateObject var userInfoViewModel: UserInfoViewModel

    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                
                GPleAsset.Assets.gpleLogo.swiftUIImage
                    .padding(.bottom, 20)
                
                Text("GSM 사진 공유 서비스")
                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
                    .padding(.bottom, 90)
                
                Spacer()
                
                GPleAsset.Assets.map.swiftUIImage
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: 410, height: 500)
            }
            
            VStack {
                Spacer()
                
                LoginButton(loginViewModel: viewModel)
                    .padding(.bottom, 40)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isSignedIn) {
            UserInfoView(viewModel: UserInfoViewModel())
        }
    }
}
