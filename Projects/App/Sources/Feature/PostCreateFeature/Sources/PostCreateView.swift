import SwiftUI

struct PostCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var titleTextField: String = ""
    @State private var showError: Bool = false
    @State private var images: [UIImage?] = [nil, nil, nil]

    var body: some View {
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
                    Text("사진 업로드")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)

                Text("사진")
                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                    .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                    .padding(.leading, 24)
                    .padding(.top, 24)

                HStack(spacing: 12) {
                        if let image = images[0] {
                            Image(uiImage: image)
                        } else {
                            Image("imageFrame")
                        }

                    VStack(spacing: 8) {
                        if images[0] != nil {
                            (images[1] != nil ? Image(uiImage: images[1]!) : Image("imageFrame"))
                                .resizable()
                                .frame(width: 76, height: 76)
                                .clipped()
                        }

                        if images[1] != nil {
                            (images[2] != nil ? Image(uiImage: images[2]!) : Image("imageFrame"))
                                .resizable()
                                .frame(width: 76, height: 76)
                                .clipped()
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 6)


//                GPleTextField(
//                    "제목을 입력해주세요",
//                    text: $titleTextField,
//                    title: "제목",
//                    textCount: titleTextField.count,
//                    useTextCount: true,
//                    errorText: "제목을 입력 해주세요.",
//                    isError: showError,
//                    onSubmit: {
//                        if titleTextField.isEmpty {
//                            showError = true
//                        } else {
//                            showError = false
//                        }
//                    }
//                )
                
                Spacer()
            }
        }
    }
}

#Preview {
    PostCreateView()
}
