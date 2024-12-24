import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            RankView(viewModel: DetailViewModel())
        }
    }
}
