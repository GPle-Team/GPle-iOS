import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            MyPageView(viewModel: MyPageViewModel(), postViewModel: PostViewModel())
        }
    }
}
