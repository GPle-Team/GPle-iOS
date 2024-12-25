import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            //MainView(viewModel: MainViewModel(), postViewModel: PostViewModel())
            //MyPageView(viewModel: MyPageViewModel(), postViewModel: PostViewModel())
            PostCreateView(viewModel: PostViewModel())
        }
    }
}
