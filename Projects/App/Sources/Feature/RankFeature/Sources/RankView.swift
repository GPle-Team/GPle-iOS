import SwiftUI

struct RankView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var postViewModel: PostViewModel

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
                                    .padding(.leading, 20)
                            }
                            Spacer()
                        }

                        Text("인기 순위")
                            .foregroundStyle(.white)
                            .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                            .padding(.vertical, 16)
                    }
                    .padding(.bottom, 16)

                    ScrollView(showsIndicators: false) {
                        HStack(spacing: 0) {
                            VStack(spacing: 4) {
                                Text("2위")
                                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                    .padding(.top, 16.5)

                                Text("한재형")
                                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                    .padding(.bottom, 8)

                                GPleAsset.Assets.second.swiftUIImage
                            }

                            VStack(spacing: 4) {
                                Text("1위")
                                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                    .foregroundStyle(GPleAsset.Color.rank1.swiftUIColor)

                                Text("한재형")
                                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                    .padding(.bottom, 8)

                                GPleAsset.Assets.first.swiftUIImage
                            }

                            VStack(spacing: 4) {
                                Text("3위")
                                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                    .foregroundStyle(GPleAsset.Color.rank2.swiftUIColor)
                                    .padding(.top, 28)

                                Text("한재형")
                                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                    .padding(.bottom, 8)

                                GPleAsset.Assets.third.swiftUIImage
                            }
                        }
                        .padding(.horizontal, 15)

                        ForEach(postViewModel.popularityPostList, id: \.id) { popularityPost in

                            Rectangle()
                                .frame(height: 4)
                                .foregroundStyle(GPleAsset.Color.gray1050.swiftUIColor)
                                .padding(.top, 15)

                            DetailView(
                                viewModel: DetailViewModel(),
                                postViewModel: PostViewModel(),
                                postId: popularityPost.id,
                                title: popularityPost.title,
                                name: popularityPost.author.name,
                                grade: popularityPost.author.grade,
                                imageUrl: popularityPost.imageUrl,
                                tagList: popularityPost.tagList.map { ($0.name, $0.id) },
                                emojiList: [
                                    popularityPost.emojiList.heartCount,
                                    popularityPost.emojiList.congCount,
                                    popularityPost.emojiList.thumbsCount,
                                    popularityPost.emojiList.thinkCount,
                                    popularityPost.emojiList.poopCount,
                                    popularityPost.emojiList.chinaCount
                                ],
                                checkEmojiList: popularityPost.checkEmoji,
                                createTime: popularityPost.createdTime
                            )
                        }
                    }
                }
            }
        }
        .onAppear {
            postViewModel.popularityPostList { success in
                if success {
                    print("인기순위 게시물 불러오기 성공")
                } else {
                    print("인기순위 게시물 불러오기 실패")
                }
            }
        }
    }
}
