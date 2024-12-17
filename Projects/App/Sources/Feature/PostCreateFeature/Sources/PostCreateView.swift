import SwiftUI

struct PostCreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var titleTextField: String = ""
    @State private var showError: Bool = false

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
                
                Spacer()
            }
        }
    }
}

#Preview {
    PostCreateView()
}
