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

    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 0) {
                ZStack {
                    HStack {
                        GPleAsset.Assets.chevronRight.swiftUIImage
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Text("자세히 보기")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                }
                .padding(.bottom, 16)

                ScrollView {
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

                    HStack(spacing: 8) {
                        ForEach(viewModel.tagUser, id: \.self) { tag in
                            Text("@\(tag)")
                                .foregroundStyle(GPleAsset.Color.gray600.swiftUIColor)
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        }
                    }
                   .padding(.top, 1)

                    Text("\(viewModel.wwDay)월 \(viewModel.ddDay)일")
                        .foregroundStyle(GPleAsset.Color.gray800.swiftUIColor)
                        .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                        .padding(.top, 1)
                }

                Spacer()
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel())
}
