import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    GPleAsset.Assets.gpleBigLogo.swiftUIImage
                        .padding(.leading, 20)

                    Spacer()

                    GPleAsset.Assets.profile.swiftUIImage
                        .padding(.trailing, 20)
                }
                .padding(.top, 16)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}
