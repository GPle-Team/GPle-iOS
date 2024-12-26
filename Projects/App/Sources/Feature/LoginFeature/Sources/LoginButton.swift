import SwiftUI

struct LoginButton: View {
    @StateObject var loginViewModel: LoginViewModel
    
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
            .background(GPleAsset.Color.white.swiftUIColor)
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
        }
        
    }
}
