import UIKit
import SwiftUI

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("이미지 로드 실패: \(String(describing: error))")
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                print("이미지 변환 실패")
            }
        }.resume()
    }
}

struct ImageViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> UIImageView {
        return UIImageView()
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.loadImage(from: url)
    }
}
