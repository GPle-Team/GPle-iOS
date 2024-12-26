import Foundation

final class UserInfoViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var number: String = ""
}
