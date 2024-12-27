import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            RankView(postViewModel: PostViewModel())
            //MyPageView(viewModel: MyPageViewModel(),postViewModel: PostViewModel())
        }
    }
}
