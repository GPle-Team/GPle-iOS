import UIKit
import SwiftUI

extension UIImageView {
    func loadImage(from url: URL) {
        // 비동기적으로 이미지 다운로드
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("이미지 로드 실패: \(String(describing: error))")
                return
            }

            // 데이터로부터 UIImage 생성
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image // 메인 스레드에서 UI 업데이트
                }
            } else {
                print("이미지 변환 실패")
            }
        }.resume() // 작업 시작
    }
}

struct ImageViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> UIImageView {
        return UIImageView()
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.loadImage(from: url) // 확장에서 만든 메서드 사용
    }
}
