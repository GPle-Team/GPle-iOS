import SwiftUI

struct MainView: View {
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

                    ForEach(0..<3) { _ in
                        postList(
                            name: "한재형",
                            grade: "2학년",
                            title: "유성이 없이 방송부원들과",
                            place: "운동장",
                            tag: "@박미리",
                            date: "9월 12일"
                        )
                    }
                    .padding(.top, 60)

                    Spacer()
                }
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
        grade: String,
        title: String,
        place: String,
        tag: String,
        date: String
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

                Text(grade)
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

            GPleAsset.Assets.testImage.swiftUIImage
                .resizable()
                .cornerRadius(8)
                .frame(width: 318, height: 318)
                .padding(.top, 16)

            HStack(spacing: 8) {
                ForEach(0..<2) { _ in
                    Text(tag)
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
