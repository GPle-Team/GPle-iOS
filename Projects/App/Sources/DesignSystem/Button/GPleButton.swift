import SwiftUI

public struct GPleButton: View {
    var text: String
    var horizontalPadding: CGFloat
    var verticalPadding: CGFloat
    var backColor: Color
    var buttonState: Bool
    var buttonOkColor: Color
    var action: () -> Void

    @State private var isPressed = false

    public init(
        text: String,
        horizontalPadding: CGFloat = 16,
        verticalPadding: CGFloat = 8,
        backColor: Color,
        buttonState: Bool,
        buttonOkColor: Color,
        action: @escaping () -> Void = {}
    ) {
        self.text = text
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.backColor = backColor
        self.buttonState = buttonState
        self.buttonOkColor = buttonOkColor
        self.action = action
    }

    public var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(text)
                .font(GPleFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
                .foregroundStyle(buttonState ? .white : GPleAsset.Color.gray600.swiftUIColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, verticalPadding)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(buttonState ? buttonOkColor : backColor)
                )
                .padding(.horizontal, horizontalPadding)
                .scaleEffect(isPressed ? 0.9 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in self.isPressed = true }
                .onEnded { _ in
                    self.isPressed = false
                    self.action()
                }
        )
    }
}
