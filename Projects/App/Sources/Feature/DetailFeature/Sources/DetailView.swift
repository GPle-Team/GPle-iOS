//
//  DetailView.swift
//  GPle
//
//  Created by 서지완 on 10/23/24.
//  Copyright © 2024 GSM.GPle. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    @State private var topNavigationState = false
    @State private var emojiName: [String] = ["RedHeart", "PartyPopper", "ThumbsUp", "ThinkingFace", "PileOfPoo", "FlagChina"]
    @State private var emojiStates: [Int] = [100, 200, 300, 400, 500, 600]
    @State private var test = false

    var body: some View {
        ZStack(alignment: .leading) {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    HStack {
                        GPleAsset.Assets.chevronRight.swiftUIImage
                            .padding(.leading, 20)
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
                                GPleAsset.Assets.graySmile.swiftUIImage
                                    .padding(.leading, 16)

                                ForEach(0..<6) { tag in
                                    if emojiStates[tag] != 0 {
                                        emojiComponent(emojiName: emojiName[tag], emojiCount: emojiStates[tag], emojiState: $test)
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
        }
    }
}

@ViewBuilder
func emojiComponent(
    emojiName: String,
    emojiCount: Int,
    emojiState: Binding<Bool>
) -> some View {
    HStack(spacing: 6) {
        Image(emojiName)
            .resizable()
            .frame(width: 16, height: 16)
        Text("\(emojiCount)")
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

#Preview {
    DetailView(viewModel: DetailViewModel())
}
