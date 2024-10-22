import Foundation

final class MyPageViewModel: ObservableObject {
    @Published var name: String = "한재형"
    @Published var upLoadImage: Int = 9
    @Published var reactionImage: Int = 5
    @Published var isShowingBottomSheet = false
}
