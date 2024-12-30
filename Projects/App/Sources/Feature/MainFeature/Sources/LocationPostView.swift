import SwiftUI

struct LocationPostView: View {
    @StateObject var viewModel: LocationPostViewModel
    @State private var topNavigationState: Bool = false
    @Environment(\.dismiss) private var dismiss

    var locationType: String

    var body: some View {
        ZStack {
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
                    Text(locationTypeText())
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)
                
                ScrollView {
                    switch locationType {
                    case "GYM":
                        if viewModel.gymPostList.isEmpty {
                            PostEmptyView()
                        } else {
                            ForEach(viewModel.gymPostList) { post in
                                DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map{ ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.chinaCount,
                                        post.emojiList.congCount,
                                        post.emojiList.heartCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.thumbsCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )
                                
                                Rectangle()
                                    .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                    .frame(height: 3)
                                    .padding(.vertical, 10)
                            }
                        }
                    case "HOME":
                        if viewModel.homePostList.isEmpty {
                            PostEmptyView()
                        } else {
                            ForEach(viewModel.homePostList) { post in
                                DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map{ ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.chinaCount,
                                        post.emojiList.congCount,
                                        post.emojiList.heartCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.thumbsCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )
                                
                                Rectangle()
                                    .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                    .frame(height: 3)
                                    .padding(.vertical, 10)
                            }
                        }
                    case "PLAYGROUND":
                        if viewModel.playgroundPostList.isEmpty {
                            PostEmptyView()
                        } else {
                            ForEach(viewModel.playgroundPostList) { post in
                                DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map{ ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.chinaCount,
                                        post.emojiList.congCount,
                                        post.emojiList.heartCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.thumbsCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )
                                
                                Rectangle()
                                    .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                    .frame(height: 3)
                                    .padding(.vertical, 10)
                            }
                        }
                    case "DOMITORY":
                        if viewModel.domitoryPostList.isEmpty {
                            PostEmptyView()
                        } else {
                            ForEach(viewModel.domitoryPostList) { post in
                                DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map{ ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.chinaCount,
                                        post.emojiList.congCount,
                                        post.emojiList.heartCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.thumbsCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )
                                
                                Rectangle()
                                    .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                    .frame(height: 3)
                                    .padding(.vertical, 10)
                            }
                        }
                    case "WALKING_TRAIL":
                        if viewModel.walkingTrailPostList.isEmpty {
                            PostEmptyView()
                        } else {
                            ForEach(viewModel.walkingTrailPostList) { post in
                                DetailView(
                                    postViewModel: PostViewModel(),
                                    postId: post.id,
                                    title: post.title,
                                    name: post.author.name,
                                    grade: post.author.grade,
                                    imageUrl: post.imageUrl,
                                    tagList: post.tagList.map{ ($0.name, $0.id) },
                                    emojiList: [
                                        post.emojiList.chinaCount,
                                        post.emojiList.congCount,
                                        post.emojiList.heartCount,
                                        post.emojiList.poopCount,
                                        post.emojiList.thinkCount,
                                        post.emojiList.thumbsCount
                                    ],
                                    checkEmojiList: post.checkEmoji,
                                    createTime: post.createdTime
                                )
                                
                                Rectangle()
                                    .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                    .frame(height: 3)
                                    .padding(.vertical, 10)
                            }
                        }
                    default:
                        PostEmptyView()
                    }
                }
                .padding(.top, 8)
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.fetchGymList()
                viewModel.fetchDomitoryList()
                viewModel.fetchHomeList()
                viewModel.fetchPlayGroundList()
                viewModel.fetchWalkingTrailList()
            }
        }
    }
    
    func locationTypeText() -> String {
        switch locationType {
        case "GYM":
            return "금봉관"
        case "DOMITORY":
            return "동행관"
        case "HOME":
            return "본관"
        case "PLAYGROUND":
            return "운동장"
        case "WALKING_TRAIL":
            return "산책로"
        default:
            return ""
        }
    }
}
