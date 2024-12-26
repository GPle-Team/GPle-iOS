import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
//            RankView(detailViewModel: DetailViewModel(), postViewModel: PostViewModel())
            RankView(detailViewModel: DetailViewModel())
        }
    }
}
