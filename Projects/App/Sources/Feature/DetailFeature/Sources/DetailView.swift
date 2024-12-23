import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var topNavigationState: Bool = false
    @State private var emojiName: [String] = ["heart", "congrats", "thumbsup", "thinking", "poop", "china"]
    @State private var emojiStates: [Int] = [0, 2, 3, 400, 500, 600]
    @State private var test: [Bool] = [false, false, false, false, false, false]
    @State private var graySmileState: Bool = false
    @Environment(\.dismiss) private var dismiss

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
                    Text("운동장")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 4) {
                            GPleAsset.Assets.profile.swiftUIImage
                                .padding(.leading, 16)

                            Text(viewModel.name)
                                .foregroundStyle(.white)
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                .padding(.leading, 4)

                            Text("· \(viewModel.schoolYear)학년")
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 16))
                                .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)

                            Spacer()
                        }
                        .padding(.top, 8)

                        TabView(selection: $viewModel.imageCount) {
                            ForEach(0..<viewModel.imageCount) { _ in
                                GPleAsset.Assets.testimage2.swiftUIImage
                                    .resizable()
                                    .padding(.top, 12)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 381)
                        .tabViewStyle(.page)

                        Text(viewModel.title)
                            .foregroundStyle(.white)
                            .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                            .padding(.top, 16)
                            .padding(.leading, 16)

                        HStack(spacing: 8) {
                            ForEach(viewModel.tagUser, id: \.self) { tag in
                                Text("@\(tag)")
                                    .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                                    .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            }
                        }
                        .padding(.top, 6)
                        .padding(.leading, 16)

                        Text("\(viewModel.wwDay)월 \(viewModel.ddDay)일")
                            .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                            .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                            .padding(.top, 6)
                            .padding(.leading, 16)

                        VStack(alignment: .leading, spacing: 0) {
                            FlowLayout {
                                Button(action: {
                                    Haptic.impact(style: .soft)
                                    graySmileState.toggle()
                                }) {
                                    GPleAsset.Assets.graySmile.swiftUIImage
                                        .padding(.leading, 16)
                                }

                                ForEach(0..<6) { tag in
                                    if emojiStates[tag] != 0 {
                                        emojiComponent(emojiName: emojiName[tag], emojiCount: $emojiStates[tag], emojiState: $test[tag])
                                    }
                                }
                                .padding(.top, 2)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)

                    }
                }

                Spacer()
            }
            .padding(.top, 8)

            if graySmileState {
                HStack(spacing: 25) {
                    ForEach(0..<6) { tag in
                        Button(action: {
                            Haptic.impact(style: .soft)
                            test[tag].toggle()
                            if test[tag] {
                                emojiStates[tag] += 1
                            } else {
                                emojiStates[tag] -= 1
                            }
                        }) {
                            Image(emojiName[tag])
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(GPleAsset.Color.gray1000.swiftUIColor)
                )
                .padding(.leading, 20)
                .padding(.top, 490)
            }
        }
    }
}

@ViewBuilder
func emojiComponent(
    emojiName: String,
    emojiCount: Binding<Int>,
    emojiState: Binding<Bool>
) -> some View {
    Button(action: {
        Haptic.impact(style: .soft)
        emojiState.wrappedValue.toggle()
        if emojiState.wrappedValue {
            emojiCount.wrappedValue += 1
        } else {
            emojiCount.wrappedValue -= 1
        }
    }) {
        HStack(spacing: 6) {
            Image(emojiName)
                .resizable()
                .frame(width: 16, height: 16)
            Text("\(emojiCount.wrappedValue)")
                .foregroundStyle(.white)
                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(emojiState.wrappedValue ? GPleAsset.Color.secondary2.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(emojiState.wrappedValue ? GPleAsset.Color.main.swiftUIColor : GPleAsset.Color.gray1000.swiftUIColor, lineWidth: 1.5)
        )
    }
}
