import Foundation

final class DetailViewModel: ObservableObject {
    @Published var name: String = "한재형"
    @Published var schoolYear: Int = 2
    @Published var imageCount: Int = 3
    @Published var title: String = "유성이 없이 찍은 7기"
    @Published var tagUser: [String] = ["박미리", "장예슬"]
    @Published var wwDay: String = "6"
    @Published var ddDay: String = "7"
}
