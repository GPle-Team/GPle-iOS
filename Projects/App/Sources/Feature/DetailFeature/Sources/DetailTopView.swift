//
//  DetailTopView.swift
//  GPle
//
//  Created by 서지완 on 10/23/24.
//  Copyright © 2024 GSM.GPle. All rights reserved.
//

import SwiftUI

struct DetailTopView: View {
    var body: some View {
        ZStack {
            GPleAsset.Color.back.swiftUIColor
                .ignoresSafeArea()

            VStack {
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

                DetailView(viewModel: DetailViewModel())
                    .padding(.top, 16)
                Spacer()
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    DetailTopView()
}
