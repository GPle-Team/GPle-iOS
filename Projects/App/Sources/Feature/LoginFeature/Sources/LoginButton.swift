import SwiftUI

struct LoginButton: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        Button {
            loginViewModel.signIn()
        } label: {
            VStack {
                HStack(spacing: 12) {
                    Spacer()
                    
                    GPleAsset.Assets.googleLogo.swiftUIImage

                    Text("Google로 시작하기")
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                        .foregroundStyle(GPleAsset.Color.black.swiftUIColor)
                    
                    Spacer()
                }
                .padding(.horizontal, 15.5)
                .padding(.vertical, 12)
                
            }
            .padding(.horizontal, 20)
            .cornerRadius(12)
        }
    }
}
