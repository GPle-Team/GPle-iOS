import SwiftUI

@main
struct GPleApp: App {
    var body: some Scene {
        WindowGroup {
            DetailView(viewModel: DetailViewModel())
        }
    }
}
