import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var topNavigationState: Bool = false
    @State private var emojiName: [String] = ["heart", "congrats", "ThumbsUp", "thinking", "poop", "china"]
    @State private var emojiStates: [Int] = [0, 2, 3, 400, 500, 600]
    @State private var test: [Bool] = [false, false, false, false, false, false]
    @State private var graySmileState: Bool = false
    @Environment(\.dismiss) private var dismiss
    @StateObject var postViewModel: PostViewModel
    @State public var postId: Int = 0
    @State private var isDataLoaded: Bool = false
    @State public var id: Int = 0
    @State public var location: String = ""
    @State public var title: String = ""
    @State public var name: String = ""
    @State public var grade: Int = 0
    @State public var imageUrl: [String] = []
    @State public var tagList: [(name: String, id: Int)]
    @State public var emojiList: [Int] = []
    @State public var createTime: String = ""

    var body: some View {
        NavigationStack {

            ZStack(alignment: .leading) {
                GPleAsset.Color.back.swiftUIColor
                    .ignoresSafeArea()

                if isDataLoaded {
                    VStack(alignment: .leading, spacing: 0) {
                        ZStack {
                            HStack {
                                Button {
                                    dismiss()
                                } label: {
                                    GPleAsset.Assets.chevronRight.swiftUIImage
                                        .padding(.leading, 20)
                                }

                                Spacer()
                            }


                            Text(location)
                                .foregroundStyle(.white)
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))

                        }
                        .padding(.bottom, 16)

                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 4) {
                                    GPleAsset.Assets.profile.swiftUIImage
                                        .padding(.leading, 16)

                                    Text(name)
                                        .foregroundStyle(.white)
                                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                        .padding(.leading, 4)

                                    Text("· \(grade)학년")
                                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)


                                    Spacer()
                                }
                                .padding(.top, 8)

                                TabView(selection: $viewModel.imageCount) {
                                    ForEach(imageUrl.indices, id: \.self) { index in
                                        if let imageUrl = URL(string: imageUrl[index]) {
                                            AsyncImage(url: imageUrl) { image in
                                                image
                                                    .resizable()
                                                    .padding(.top, 12)
                                            } placeholder: {
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle())
                                            }
                                            .tag(index)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 381)
                                .tabViewStyle(.page)

                                Text(title)
                                    .foregroundStyle(.white)
                                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                                    .padding(.top, 16)
                                    .padding(.leading, 16)


                                HStack(spacing: 8) {
                                    ForEach(tagList.indices, id: \.self) { tag in
                                        Text("@\(tagList[tag].name)")
                                            .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                    }
                                }
                                .padding(.top, 6)
                                .padding(.leading, 16)


                                let dateString = createTime.split(separator: "T").first
                                if let dateString = dateString {
                                    let components = dateString.split(separator: "-")
                                    if components.count >= 3 {
                                        var month = String(components[1])
                                        var day = String(components[2])

                                        Text("\(month)월 \(day)일")
                                            .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                            .padding(.top, 6)
                                            .padding(.leading, 16)

                                    }
                                }

                                VStack(alignment: .leading, spacing: 0) {
                                    FlowLayout {
                                        Button(action: {
                                            Haptic.impact(style: .soft)
                                            graySmileState.toggle()
                                        }) {
                                            GPleAsset.Assets.graySmile.swiftUIImage
                                                .padding(.leading, 16)
                                        }

                                        ForEach(0..<6) { tag in
                                            if emojiList[tag] != 0 {
                                                emojiComponent(emojiName: emojiName[tag], emojiCount: $emojiList[tag], emojiState: $test[tag])
                                            }
                                        }
                                        .padding(.top, 2)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 8)
                            }
                        }

                        Spacer()
                    }
                    .padding(.top, 8)

                    if graySmileState {
                        HStack(spacing: 25) {
                            ForEach(0..<6) { tag in
                                Button(action: {
                                    Haptic.impact(style: .soft)
                                    test[tag].toggle()
                                    if test[tag] {
                                        emojiStates[tag] += 1
                                    } else {
                                        emojiStates[tag] -= 1
                                    }
                                }) {
                                    Image(emojiName[tag])
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                        )
                        .padding(.leading, 20)
                        .padding(.top, 490)
                    }
                } else {
                    ProgressView("불러오는중...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadPostData()
        }
    }

    private func loadPostData() {
        postViewModel.myPostList { success in
            if success {
                isDataLoaded = true
                print("게시물 목록 로드 성공!")
            } else {
                print("게시물 목록 로드 실패!")
            }
        }
    }
}

@ViewBuilder
func emojiComponent(
    emojiName: String,
    emojiCount: Binding<Int>,
    emojiState: Binding<Bool>
) -> some View {
    Button(action: {
        Haptic.impact(style: .soft)
        emojiState.wrappedValue.toggle()
        if emojiState.wrappedValue {
            emojiCount.wrappedValue += 1
        } else {
            emojiCount.wrappedValue -= 1
        }
    }) {
        HStack(spacing: 6) {
            Image(emojiName)
                .resizable()
                .frame(width: 16, height: 16)
            Text("\(emojiCount.wrappedValue)")
                .foregroundStyle(.white)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(emojiState.wrappedValue ? GPleAsset.Color.secondary2.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(emojiState.wrappedValue ? GPleAsset.Color.main.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor, lineWidth: 1.5)
        )
    }
}
