import SwiftUI
import Domain

struct MyPageView: View {
    @StateObject var viewModel: MyPageViewModel
    @State private var topNavigationState = false
    @StateObject var postViewModel: PostViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                GPleAsset.Color.back.swiftUIColor
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        GPleAsset.Assets.gpleBigLogo.swiftUIImage
                            .padding(.leading, 20)

                        Spacer()

                        Button {
                            dismiss()
                        } label: {
                            GPleAsset.Assets.home.swiftUIImage
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.top, 16)

                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(postViewModel.myInfo?.name ?? "")님,")
                                .foregroundStyle(.white)
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 20))

                            HStack(spacing: 0) {
                                Text(topNavigationState ? String(postViewModel.myReactionPostList.count) : String(postViewModel.myPostList.count))
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
                            Button("프로필 변경", action: {
                            })
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
                                postViewModel.myPostList{ success in
                                    if success {
                                        topNavigationState = false
                                        print("Viewㅣ게시물 불러오기 성공~!!!")
                                    } else {
                                        print("Viewㅣ게시물 불러오기 실패")
                                    }
                                }
                            } label: {
                                GPleAsset.Assets.image.swiftUIImage
                                    .foregroundStyle(.white)
                                    .frame(width: UIScreen.main.bounds.width / 2)
                            }

                            Spacer()

                            Button {
                                postViewModel.myReactionPostList { success in
                                    if success {
                                        topNavigationState = true
                                        print("Viewㅣ게시물 불러오기 성공~!!!")
                                    } else {
                                        print("Viewㅣ게시물 불러오기 실패")
                                    }
                                }
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
                            let columns = [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ]

                            ScrollView {
                                LazyVGrid(columns: columns, spacing: 2) {
                                    ForEach(postViewModel.myPostList, id: \.id) { myPost in

                                        NavigationLink(destination: DetailView(
                                            viewModel: DetailViewModel(),
                                            postViewModel: PostViewModel(),
                                            postId: myPost.id,
                                            location: myPost.location,
                                            title: myPost.title,
                                            name: myPost.author.name,
                                            grade: myPost.author.grade,
                                            imageUrl: myPost.imageUrl,
                                            tagList: myPost.tagList.map { ($0.name, $0.id) },
                                            emojiList: [
                                                myPost.emojiList.heartCount,
                                                myPost.emojiList.congCount,
                                                myPost.emojiList.thumbsCount,
                                                myPost.emojiList.thinkCount,
                                                myPost.emojiList.poopCount,
                                                myPost.emojiList.chinaCount
                                            ],
                                            checkEmojiList: myPost.checkEmoji,
                                            createTime: myPost.createdTime
                                        )) {
                                            if let imageUrl = myPost.imageUrl.first {
                                                AsyncImage(url: URL(string: imageUrl)) { image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 135, height: 135)
                                                        .clipped()
                                                } placeholder: {
                                                    Rectangle()
                                                        .frame(width: 135, height: 135)
                                                        .foregroundStyle(GPleAsset.Color.back.swiftUIColor)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .tag(false)

                            let columns1 = [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ]

                            ScrollView {
                                LazyVGrid(columns: columns1, spacing: 2) {
                                    ForEach(postViewModel.myReactionPostList, id: \.id) { rtPost in

                                        NavigationLink(destination: DetailView(
                                            viewModel: DetailViewModel(),
                                            postViewModel: PostViewModel(),
                                            postId: rtPost.id,
                                            location: rtPost.location,
                                            title: rtPost.title,
                                            name: rtPost.author.name,
                                            grade: rtPost.author.grade,
                                            imageUrl: rtPost.imageUrl,
                                            tagList: rtPost.tagList.map { ($0.name, $0.id) },
                                            emojiList: [
                                                rtPost.emojiList.heartCount,
                                                rtPost.emojiList.congCount,
                                                rtPost.emojiList.thumbsCount,
                                                rtPost.emojiList.thinkCount,
                                                rtPost.emojiList.poopCount,
                                                rtPost.emojiList.chinaCount
                                            ],
                                            checkEmojiList: rtPost.checkEmoji,
                                            createTime: rtPost.createdTime
                                        )) {
                                            if let imageUrl = rtPost.imageUrl.first {
                                                AsyncImage(url: URL(string: imageUrl)) { image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 135, height: 135)
                                                        .clipped()
                                                } placeholder: {
                                                    Rectangle()
                                                        .frame(width: 135, height: 135)
                                                        .foregroundStyle(GPleAsset.Color.back.swiftUIColor)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .tag(true)
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))

                        Spacer()
                    }

                    Spacer()
                }
            }
        }
        .onAppear {
            postViewModel.myPostList { success in
                if success {
                    print("내 게시물 최신화 성공")
                } else {
                    print("내 게시물 최신화 실패")
                }
            }
            postViewModel.myReactionPostList { success in
                if success {
                    print("반응 게시물 최신화 성공")
                } else {
                    print("반응 게시물 최신화 실패")
                }
            }

            postViewModel.myInfo { success in
                if success {
                    print("내 정보 불러오기 성공")
                } else {
                    print("내 정보 불러오기 실패")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
