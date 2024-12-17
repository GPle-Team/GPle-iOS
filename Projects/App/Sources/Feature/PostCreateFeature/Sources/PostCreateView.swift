import SwiftUI

struct PostCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var titleTextField: String = ""
    @State private var showError: Bool = false
    @State private var images: [UIImage?] = [nil, nil, nil]
    @State private var showingImagePicker = false
    @State private var imagesPickerIndex = 0
    @State var showingSheet = false

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
                    Group {
                        if let image = images[0] {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 160, height: 160)
                                .cornerRadius(8)
                        } else {
                            Image("imageFrame")
                        }
                    }
                    .onTapGesture {
                        if images[0] == nil {
                            imagesPickerIndex = 0
                            showingImagePicker = true
                        } else {
                            imagesPickerIndex = 0
                            self.showingSheet = true
                        }
                    }

                    VStack(spacing: 8) {
                        (images[1] != nil ? Image(uiImage: images[1]!) : Image("imageFrame"))
                            .resizable()
                            .frame(width: 76, height: 76)
                            .cornerRadius(8)
                            .onTapGesture {
                                if images[1] == nil {
                                    imagesPickerIndex = 1
                                    showingImagePicker = true
                                } else {
                                    imagesPickerIndex = 1
                                    self.showingSheet = true
                                }
                            }


                        (images[2] != nil ? Image(uiImage: images[2]!) : Image("imageFrame"))
                            .resizable()
                            .frame(width: 76, height: 76)
                            .cornerRadius(8)
                            .onTapGesture {
                                if images[2] == nil {
                                    imagesPickerIndex = 2
                                    showingImagePicker = true
                                } else {
                                    imagesPickerIndex = 2
                                    self.showingSheet = true
                                }
                            }
                    }

                }
                .padding(.leading, 20)
                .padding(.top, 6)

                Text("사진은 최대 3개까지 업로드가 가능합니다.")
                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                    .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                    .padding(.leading, 20)
                    .padding(.top, 8)
                

                GPleTextField(
                    "제목을 입력해주세요",
                    text: $titleTextField,
                    title: "제목",
                    textCount: titleTextField.count,
                    useTextCount: true,
                    errorText: "제목을 입력 해주세요.",
                    isError: showError,
                    onSubmit: {
                        if titleTextField.isEmpty {
                            showError = true
                        } else {
                            showError = false
                        }
                    }
                )
                .padding(.top, 32)

                Spacer()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(selectedImage: $images[imagesPickerIndex])
            }
            .confirmationDialog("", isPresented: $showingSheet, titleVisibility: .hidden) {
                Button("사진 변경") {
                    showingImagePicker = true
                }
                Button("사진 삭제", role: .destructive) {
                    images.remove(at: imagesPickerIndex)
                    images.append(nil)
                }
                Button("취소", role: .cancel) {
                }
            }
        }
    }
}

#Preview {
    PostCreateView()
}
