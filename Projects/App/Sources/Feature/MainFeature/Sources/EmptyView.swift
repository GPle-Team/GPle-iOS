import SwiftUI

struct EmptyView: View {
    var body: some View {
        NavigationView {
            NavigationStack {
                ZStack {
                        GPleAsset.Color.back.swiftUIColor
                            .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        Text("아무것도 없어요...")
                            .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                            .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 24))
                        
                        Text("재밌는 사진을 모두와 공유해요!")
                            .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                            .padding(.top, 4)
                        
                        NavigationLink {
                            PostCreateView(viewModel: PostViewModel())
                        } label: {
                            imageUploadButton()
                                .padding(.top, 20)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func imageUploadButton() -> some View {
        HStack {
            GPleAsset.Assets.download.swiftUIImage

            Text("사진 업로드")
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
        }
        .padding(.all, 12)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(8)
    }
}

#Preview {
    EmptyView()
}
