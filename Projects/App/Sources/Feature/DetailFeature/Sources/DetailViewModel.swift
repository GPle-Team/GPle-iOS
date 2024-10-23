import Foundation

final class DetailViewModel: ObservableObject {
    @Published var name: String = "한재형"
    @Published var schoolYear: Int = 2
    @Published var imageCount: Int = 3
}
