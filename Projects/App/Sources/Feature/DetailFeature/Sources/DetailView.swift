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
            VStack (spacing: 0){
                HStack(spacing: 4){
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

                Spacer()
            }
            .padding(.top, 8)
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel())
}
