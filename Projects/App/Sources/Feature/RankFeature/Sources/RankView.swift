import SwiftUI

struct RankView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: DetailViewModel
    
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
                    
                    Text("인기 순위")
                        .foregroundStyle(.white)
                        .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 18))
                        .padding(.vertical, 16)
                }
                .padding(.bottom, 16)
                
                ScrollView(showsIndicators: false) {
                    HStack(spacing: 0) {
                        VStack(spacing: 4) {
                            Text("2위")
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                .padding(.top, 16.5)
                            
                            Text("한재형")
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                .padding(.bottom, 8)
                            
                            GPleAsset.Assets.second.swiftUIImage
                        }
                        
                        VStack(spacing: 4) {
                            Text("1위")
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                .foregroundStyle(GPleAsset.Color.rank1.swiftUIColor)
                            
                            Text("한재형")
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                .padding(.bottom, 8)
                            
                            GPleAsset.Assets.first.swiftUIImage
                        }
                        
                        VStack(spacing: 4) {
                            Text("3위")
                                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                                .foregroundStyle(GPleAsset.Color.rank2.swiftUIColor)
                                .padding(.top, 28)
                            
                            Text("한재형")
                                .font(GPleFontFamily.Pretendard.regular.swiftUIFont(size: 14))
                                .foregroundStyle(GPleAsset.Color.gray400.swiftUIColor)
                                .padding(.bottom, 8)
                            
                            GPleAsset.Assets.third.swiftUIImage
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.bottom, 28)
                    
                    DetailView(viewModel: DetailViewModel())
                }
            }
        }
    }
}
