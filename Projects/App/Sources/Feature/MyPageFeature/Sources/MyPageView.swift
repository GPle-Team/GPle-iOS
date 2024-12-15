import SwiftUI

struct MyPageView: View {
    @StateObject var viewModel: MyPageViewModel
    @State private var topNavigationState = false

    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    GPleAsset.Assets.gpleBigLogo.swiftUIImage
                        .padding(.leading, 20)

                    Spacer()

                    GPleAsset.Assets.profile.swiftUIImage
                        .padding(.trailing, 20)
                }
                .padding(.top, 16)

                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.name)님,")
                            .foregroundStyle(.white)
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 20))

                        HStack(spacing: 0) {
                            Text(topNavigationState ? String(viewModel.reactionImage) : String(viewModel.uploadImage))
                                .foregroundStyle(GPleAsset.Color.main.swiftUIColor)
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
                            Text(topNavigationState ? "개의 사진에 반응하셨어요!" : "개의 사진을 올리셨어요!")
                                .foregroundStyle(.white)
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 20))
                        }
                    }
                    .padding(.top, 44)
                    .padding(.leading, 20)

                    Spacer()

                    Menu {
                        Button("프로필 변경", action: { /* 액션 */ })
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                        Button("로그아웃", action: { /* 액션 */ })
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                            .foregroundStyle(GPleAsset.Color.system.swiftUIColor)

                    } label: {
                        GPleAsset.Assets.point3.swiftUIImage
                            .padding(.trailing, 20)
                            .padding(.top, 8)
                    }

                }

                VStack(alignment: topNavigationState ? .trailing : .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Button {
                            topNavigationState = false
                        } label: {
                            GPleAsset.Assets.image.swiftUIImage
                                .foregroundStyle(.white)
                                .frame(width: UIScreen.main.bounds.width / 2)
                        }

                        Spacer()

                        Button {
                            topNavigationState = true
                        } label: {
                            GPleAsset.Assets.smile.swiftUIImage
                                .foregroundStyle(.white)

                        }
                    }
                    .padding(.top, 32)

                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width / 2, height: 2)
                            .animation(.easeInOut(duration: 0.2), value: topNavigationState)
                            .background(
                                Rectangle()
                                    .foregroundStyle(.clear)
                                    .frame(width: 1000, height: 2)

                            )

                    TabView(selection: $topNavigationState) {
                        alignmentImages(imageCount: viewModel.uploadImage)
                        .tag(false)

                        alignmentImages(imageCount: viewModel.reactionImage)
                            .tag(true)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    Spacer()
                }

                Spacer()
            }
        }
    }
}

@ViewBuilder
func alignmentImages(
    imageCount: Int
) -> some View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    ScrollView {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(0..<imageCount) { _ in
                GPleAsset.Assets.testImage.swiftUIImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 135, height: 135)
                    .clipped()
            }
        }
    }
}

#Preview {
    MyPageView(viewModel: MyPageViewModel())
}
