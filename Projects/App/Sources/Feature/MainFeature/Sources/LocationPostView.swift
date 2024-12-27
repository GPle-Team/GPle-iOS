import SwiftUI

struct LocationPostView: View {
    @StateObject var viewModel: LocationPostViewModel
    @State private var topNavigationState: Bool = false
    @State private var emojiName: [String] = ["heart", "congrats", "thumbsup", "thinking", "poop", "china"]
    @State private var emojiStates: [Int] = [0, 2, 3, 400, 500, 600]
    @State private var test: [Bool] = [false, false, false, false, false, false]
    @State private var graySmileState: Bool = false
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
                    Text(locationType)
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)

                ScrollView {
                    switch locationType {
                    case "GYM":
                        ForEach(viewModel.gymPostList) { post in
                            postComponent(
                                name: post.author.name,
                                grade: post.author.grade,
                                title: post.title,
                                createdTime: post.createdTime,
                                tag: post.tagList.map { $0.name },
                                imageURL: post.imageUrl
                            )

                            Rectangle()
                                .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                .frame(height: 3)
                                .padding(.vertical, 10)
                        }
                    case "HOME":
                        ForEach(viewModel.homePostList) { post in
                            postComponent(
                                name: post.author.name,
                                grade: post.author.grade,
                                title: post.title,
                                createdTime: post.createdTime,
                                tag: post.tagList.map { $0.name },
                                imageURL: post.imageUrl
                            )
                            
                            Rectangle()
                                .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                .frame(height: 3)
                                .padding(.vertical, 10)
                        }
                    case "PLAYGROUND":
                        ForEach(viewModel.playgroundPostList) { post in
                            postComponent(
                                name: post.author.name,
                                grade: post.author.grade,
                                title: post.title,
                                createdTime: post.createdTime,
                                tag: post.tagList.map { $0.name },
                                imageURL: post.imageUrl
                            )
                            
                            Rectangle()
                                .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                .frame(height: 3)
                                .padding(.vertical, 10)
                        }
                    case "DOMITORY":
                        ForEach(viewModel.domitoryPostList) { post in
                            postComponent(
                                name: post.author.name,
                                grade: post.author.grade,
                                title: post.title,
                                createdTime: post.createdTime,
                                tag: post.tagList.map { $0.name },
                                imageURL: post.imageUrl
                            )

                            Rectangle()
                                .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                .frame(height: 3)
                                .padding(.vertical, 10)
                        }
                    case "WALKING_TRAIL":
                        ForEach(viewModel.walkingTrailPostList) { post in
                            postComponent(
                                name: post.author.name,
                                grade: post.author.grade,
                                title: post.title,
                                createdTime: post.createdTime,
                                tag: post.tagList.map { $0.name },
                                imageURL: post.imageUrl
                            )

                            Rectangle()
                                .foregroundStyle(GPleAsset.Color.gray900.swiftUIColor)
                                .frame(height: 3)
                                .padding(.vertical, 10)
                        }
                    default:
                        EmptyView()
                    }
                }
            }
            .padding(.top, 8)
        }
        .onAppear {
            viewModel.fetchPostListByLocation(type: locationType)
        }
        .navigationBarBackButtonHidden()
    }

    @ViewBuilder
    func postComponent(
        name: String,
        grade: Int,
        title: String,
        createdTime: String,
        tag: [String],
        imageURL: [String]
    ) -> some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 4) {
                    GPleAsset.Assets.profile.swiftUIImage

                    Text(name)
                        .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                        .padding(.leading, 4)

                    Text("•  \(grade)학년")
                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))

                    Spacer()
                }
            }
            .padding(.leading, 16)

            ForEach(imageURL, id: \.self) { imageURL in
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty, .failure:
                        EmptyView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .padding(.top, 16)

            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                        .padding(.top, 16)

                    HStack(spacing: 8) {
                        ForEach(tag, id: \.self) { tag in
                                Text("@\(tag)")
                        }
                    }
                    .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                    .padding(.top, 12)

                    Text(createdTime)
                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .padding(.top, 4)
                }
                .padding(.leading, 16)

                Spacer()
            }
        }
    }
}
