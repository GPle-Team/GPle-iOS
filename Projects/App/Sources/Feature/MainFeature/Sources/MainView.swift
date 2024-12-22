import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()

    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        GPleAsset.Assets.gpleBigLogo.swiftUIImage
                            .padding(.leading, 20)

                        Spacer()

                        GPleAsset.Assets.profile.swiftUIImage
                            .padding(.trailing, 20)
                    }
                    .padding(.top, 16)

                    GPleAsset.Assets.backyard.swiftUIImage
                        .padding(.top, 61)

                    GPleAsset.Assets.bongwan.swiftUIImage
                        .padding(.top, 6)

                    HStack(spacing: 13) {
                        GPleAsset.Assets.geumbongGwan.swiftUIImage

                        GPleAsset.Assets.playground.swiftUIImage

                        GPleAsset.Assets.dongHaengGwan.swiftUIImage
                    }
                    .padding(.top, 8)

                    HStack(spacing: 16) {
                        Spacer()

                        GPleAsset.Assets.zoomOut.swiftUIImage

                        GPleAsset.Assets.zoomIn.swiftUIImage
                    }
                    .padding(.top, 19)
                    .padding(.trailing, 24)

                    HStack(spacing: 36) {
                        rankButton()

                        imageUploadButton()
                    }
                    .padding(.top, 40)

                    ForEach(viewModel.allPostList) { post in
                        postList(
                            name: post.author.name,
                            grade: post.author.grade,
                            title: post.title,
                            place: post.location,
                            tag: post.tagList.map { $0.name },
                            date: post.createdTime,
                            imageURL: post.imageUrl
                        )
                    }
                    .padding(.top, 60)

                    Spacer()
                }
            }
            .onAppear {
                viewModel.fetchAllPostList()
            }
        }
    }

    @ViewBuilder
    func rankButton() -> some View {
        HStack {
            GPleAsset.Assets.chart.swiftUIImage

            Text("인기 순위")
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
        }
        .padding(.all, 12)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(8)
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

    @ViewBuilder
    func postList(
        name: String,
        grade: Int,
        title: String,
        place: String,
        tag: [String],
        date: String,
        imageURL: [String]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 4) {
                GPleAsset.Assets.profile.swiftUIImage

                Text(name)
                    .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                    .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                    .padding(.leading, 4)

                Text("•")
                    .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)

                HStack(spacing: 0) {
                    Text("\(grade)")

                    Text("학년")
                }
                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
            }

            Text(title)
                .foregroundStyle(GPleAsset.Color.white.swiftUIColor)
                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                .padding(.top, 16)

            Text(place)
                .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .padding(.top, 4)
            
            ForEach(imageURL, id: \.self) { imageURL in
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 318, height: 318)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 318)
                                .cornerRadius(8)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .frame(width: 318, height: 318)
                        @unknown default:
                            EmptyView()
                        }
                }
            }
            .padding(.top, 16)

            HStack(spacing: 8) {
                ForEach(tag, id: \.self) { tag in
                    HStack(spacing: 0) {
                        Text("@")
                        
                        Text(tag)
                    }
                }
            }
            .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
            .padding(.top, 12)

            Text(date)
                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                .padding(.top, 4)

        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(GPleAsset.Color.gray1000.swiftUIColor)
        .cornerRadius(12)
    }
}
