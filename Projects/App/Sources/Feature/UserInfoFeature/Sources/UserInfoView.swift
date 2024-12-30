import SwiftUI

struct UserInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isSuccess: Bool = false
    @StateObject var viewModel: UserInfoViewModel
    
    var body: some View {
        NavigationStack {
        ZStack(alignment: .leading) {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            GPleAsset.Assets.chevronRight.swiftUIImage
                        }
                        Spacer()
                    }

                    Text("정보 입력")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)
                .padding(.top, 8)
                .padding(.horizontal, 20)

                VStack(spacing: 0) {
                    HStack {
                        Text("정보를 입력해 주세요")
                            .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 24))
                            .foregroundStyle(GPleAsset.Color.white.swiftUIColor)

                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 8)

                    HStack {
                        Text("원활한 서비스를 위해 정보를 입력해 주세요")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                            .foregroundStyle(GPleAsset.Color.white.swiftUIColor)

                        Spacer()
                    }
                    .padding(.bottom, 20)

                    HStack {
                        Text("이름")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.white.swiftUIColor)

                        Spacer()
                    }
                    .padding(.bottom, 4)
                }
                .padding(.horizontal, 20)

                GPleTextField("이름을 입력해 주세요", text: $viewModel.name)

                HStack {
                    Text("학번")
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .foregroundStyle(GPleAsset.Color.white.swiftUIColor)

                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 4)

                GPleTextField("학번을 입력해 주세요", text: $viewModel.number)

                Spacer()

                GPleButton(text: "완료",
                           horizontalPadding: 20,
                           verticalPadding: 16,
                           backColor: GPleAsset.Color.gray1000.swiftUIColor,
                           buttonState: viewModel.name.isEmpty == false && viewModel.number.isEmpty == false,
                           buttonOkColor: GPleAsset.Color.main.swiftUIColor
                ) {
                    viewModel.submitUserInfo { success in
                                            if success {
                                                isSuccess = true
                                                print("정보 전송 성공!!")
                                            } else {
                                                print("정보 전송 실패!!")
                                            }
                                        }
                }
                .padding(.bottom, 12)

                NavigationLink(
                    destination: MainView(viewModel: MainViewModel(), postViewModel: PostViewModel()),
                                    isActive: $isSuccess
                                ) {
                                    EmptyView()
                                }
            }
        }
    }
        .navigationBarBackButtonHidden(true)
    }
}
