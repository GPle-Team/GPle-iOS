import SwiftUI

struct GPleTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    var title: String
    var placeholder: String
    var textCount: Int
    var useTextCount: Bool
    var errorText: String
    var isError: Bool
    var onSubmit: () -> Void

    private var borderColor: Color {
        if isError {
            return GPleAsset.Color.system.swiftUIColor
        } else {
            return GPleAsset.Color.gray1000.swiftUIColor
        }
    }

    public init(
        _ placeholder: String = "",
        text: Binding<String>,
        title: String = "",
        textCount: Int = 0,
        useTextCount: Bool = false,
        errorText: String = "",
        isError: Bool = false,
        onSubmit: @escaping () -> Void = {}
    ) {
        self._text = text
        self.placeholder = placeholder
        self.title = title
        self.textCount = textCount
        self.useTextCount = useTextCount
        self.errorText = errorText
        self.isError = isError
        self.onSubmit = onSubmit
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 0) {
                if !title.isEmpty {
                    Text(title)
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                }

                Spacer()

                if useTextCount {
                    HStack(spacing: 0) {
                        Text("\(textCount)")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                        Text("/50")
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                    }
                    .padding(.trailing, 2)
                }
            }

            TextField("", text: $text, prompt: Text(placeholder).foregroundColor(GPleAsset.Color.gray800.swiftUIColor))
                .padding(.horizontal, 16)
                .frame(height: 50)
                .onSubmit(onSubmit)
                .focused($isFocused)
                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                .accentColor(GPleAsset.Color.gray800.swiftUIColor)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                .background(GPleAsset.Color.gray1000.swiftUIColor)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(borderColor)
                }
                .cornerRadius(8)
                .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                .onTapGesture {
                    isFocused = true
                }
                .onChange(of: text) { newValue in
                            if newValue.count > 50 {
                                text = String(newValue.prefix(50))
                            }
                        }

            if isError {
                Text(errorText)
                    .foregroundStyle(GPleAsset.Color.system.swiftUIColor)
                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 12))
            }
        }
        .padding(.horizontal, 20)
    }
}

