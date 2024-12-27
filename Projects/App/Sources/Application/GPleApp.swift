import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(postViewModel: PostViewModel())
        }
    }
}
