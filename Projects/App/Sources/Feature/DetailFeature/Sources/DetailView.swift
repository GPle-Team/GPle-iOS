import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var topNavigationState: Bool = false
    @State private var emojiName: [String] = ["heart", "congrats", "thumbsUp", "thinking", "poop", "china"]
    @State private var emojiServerName: [String] = ["HEART", "CONGRATUATION", "THUMBSUP", "THINKING", "POOP", "CHINA"]
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
    @State public var tagList: [(name: String, id: Int)] = []
    @State public var emojiList: [Int] = []
    @State public var checkEmojiList: [Bool] = []
    @State public var createTime: String = ""
    @State public var topNavigationBar: Bool = true

    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                GPleAsset.Color.back.swiftUIColor
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    ZStack {
                        if !location.isEmpty {
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
                                            emojiComponent(emojiName: emojiName[tag], emojiCount: $emojiList[tag], emojiState: $checkEmojiList[tag], emojiServerName: emojiServerName[tag])
                                        }
                                    }
                                    .padding(.top, 2)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)

                            if graySmileState {
                                HStack(spacing: 25) {
                                    ForEach(0..<6) { tag in
                                        Button(action: {
                                            Haptic.impact(style: .soft)
                                            postViewModel.setupPostId(postId: postId)
                                            postViewModel.setupEmojiType(emojiType: emojiServerName[tag])

                                            postViewModel.postEmoji { success in
                                                print("\(emojiName[tag]) 성공")

                                                if checkEmojiList[tag] == true {
                                                    emojiList[tag] -= 1
                                                    checkEmojiList[tag].toggle()
                                                } else {
                                                    emojiList[tag] = 1
                                                    checkEmojiList[tag].toggle()
                                                }
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
                                .padding(.top, 10)
                            }

                        }
                    }


                    Spacer()
                }
                .padding(.top, 8)

//                if graySmileState {
//                    HStack(spacing: 25) {
//                        ForEach(0..<6) { tag in
//                            Button(action: {
//                                Haptic.impact(style: .soft)
//                                postViewModel.setupPostId(postId: postId)
//                                postViewModel.setupEmojiType(emojiType: emojiServerName[tag])
//
//                                postViewModel.postEmoji { success in
//                                    print("\(emojiName[tag]) 성공")
//
//                                    if checkEmojiList[tag] == true {
//                                        emojiList[tag] -= 1
//                                        checkEmojiList[tag].toggle()
//                                    } else {
//                                        emojiList[tag] = 1
//                                        checkEmojiList[tag].toggle()
//                                    }
//                                }
//                            }) {
//                                Image(emojiName[tag])
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 10)
//                    .background(
//                        RoundedRectangle(cornerRadius: 5)
//                            .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
//                    )
//                    .padding(.leading, 20)
//                    //.padding(.top, 490)
//                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    func emojiComponent(
        emojiName: String,
        emojiCount: Binding<Int>,
        emojiState: Binding<Bool>,
        emojiServerName: String
    ) -> some View {
        Button(action: {
            Haptic.impact(style: .soft)

            postViewModel.setupPostId(postId: postId)
            postViewModel.setupEmojiType(emojiType: emojiServerName)

            if emojiState.wrappedValue {
                postViewModel.postEmoji { success in
                    if success {
                        emojiCount.wrappedValue -= 1
                        emojiState.wrappedValue = false
                    }
                }
            } else {
                postViewModel.postEmoji { success in
                    if success {
                        emojiCount.wrappedValue += 1
                        emojiState.wrappedValue = true
                    }
                }
            }

            if emojiCount.wrappedValue < 0 {
                emojiCount.wrappedValue = 0
            }

            postViewModel.myPostList { success in
                print("내 게시물 불러옴")
            }

            postViewModel.myReactionPostList { success in
                print("반응 게시물 불러옴")
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
}
