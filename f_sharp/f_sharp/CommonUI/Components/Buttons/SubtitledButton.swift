import SwiftUI

struct SubtitledButton<Content: View>: View {
    let text: String
    let gradientColors: [Color]
    let onAction: () -> Void
    @ViewBuilder var content: () -> Content?
    
    var body: some View {
        Button(action: {
            onAction()
        }) {
            ZStack {
                VStack {
                    Spacer()
                    
                    if let contentView = content() {
                        contentView.overlay(
                            LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)
                                .mask(contentView)
                        )
                    }
                    
                    Text(text)
                        .font(.system(size: 28, weight: .heavy))
                        .frame(width: UIScreen.main.bounds.width / 4 - 32)
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                        .mask(Text(text)
                            .font(.system(size: 28, weight: .heavy))
                        )
                    
                    Spacer()
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.clear))
        }
    }
}
