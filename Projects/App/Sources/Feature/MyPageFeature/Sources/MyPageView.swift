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
                            Text("\(viewModel.name)님,")
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
                                    ForEach(0..<postViewModel.myPostList.count, id: \.self) { post in
                                        let myPost = postViewModel.myPostList[post]

                                        let myPostEmojiArray = [
                                            myPost.emojiList.heartCount,
                                            myPost.emojiList.congCount,
                                            myPost.emojiList.thumbsCount,
                                            myPost.emojiList.thinkCount,
                                            myPost.emojiList.poopCount,
                                            myPost.emojiList.chinaCount
                                        ]

                                        let myPostCheckEmojiArray = [
                                            myPost.checkEmoji.heart,
                                            myPost.checkEmoji.cong,
                                            myPost.checkEmoji.thumbs,
                                            myPost.checkEmoji.think,
                                            myPost.checkEmoji.poop,
                                            myPost.checkEmoji.china
                                        ]

                                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(), postViewModel: PostViewModel(),location: postViewModel.myPostList[post].location,title: postViewModel.myPostList[post].title, name: postViewModel.myPostList[post].author.name, grade: postViewModel.myPostList[post].author.grade,imageUrl: postViewModel.myPostList[post].imageUrl , tagList: postViewModel.myPostList[post].tagList.map { ($0.name, $0.id) }, emojiList: myPostEmojiArray, checkEmojiList: myPostCheckEmojiArray ,createTime: postViewModel.myPostList[post].createdTime)) {


                                            if let imageUrl = postViewModel.myPostList[post].imageUrl.first {
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
                                    ForEach(0..<postViewModel.myReactionPostList.count, id: \.self) { post in

                                        let rtPost = postViewModel.myReactionPostList[post]
                                        let emojiArray = [
                                            rtPost.emojiList.heartCount,
                                            rtPost.emojiList.congCount,
                                            rtPost.emojiList.thumbsCount,
                                            rtPost.emojiList.thinkCount,
                                            rtPost.emojiList.poopCount,
                                            rtPost.emojiList.chinaCount
                                        ]

                                        let checkEmojiArray = [
                                            rtPost.checkEmoji.heart,
                                            rtPost.checkEmoji.cong,
                                            rtPost.checkEmoji.thumbs,
                                            rtPost.checkEmoji.think,
                                            rtPost.checkEmoji.poop,
                                            rtPost.checkEmoji.china
                                        ]

                                        NavigationLink(destination: DetailView(viewModel: DetailViewModel(), postViewModel: PostViewModel(), location: postViewModel.myReactionPostList[post].location, title: postViewModel.myReactionPostList[post].title, name: postViewModel.myReactionPostList[post].author.name, grade: postViewModel.myReactionPostList[post].author.grade, imageUrl: postViewModel.myReactionPostList[post].imageUrl, tagList: postViewModel.myReactionPostList[post].tagList.map { ($0.name, $0.id) }, emojiList: emojiArray, checkEmojiList: checkEmojiArray, createTime: postViewModel.myReactionPostList[post].createdTime)) {

                                            if let imageUrl = postViewModel.myReactionPostList[post].imageUrl.first {
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
            postViewModel.myPostList{ success in
                if success {
                    print("Viewㅣ게시물 불러오기 성공~!!!")
                } else {
                    print("Viewㅣ게시물 불러오기 실패")
                }
            }

            postViewModel.myReactionPostList { success in
                if success {
                    print("Viewㅣ게시물 불러오기 성공~!!!")
                } else {
                    print("Viewㅣ게시물 불러오기 실패")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
