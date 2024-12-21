import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // NavigationLink 사용하여 PostCreateView로 네비게이션
                NavigationLink(destination: PostCreateView(viewModel: PostViewModel())) {
                    Text("Toggle Toast")
                }
            }
        }
    }
}

#Preview {
    TestView()
}
