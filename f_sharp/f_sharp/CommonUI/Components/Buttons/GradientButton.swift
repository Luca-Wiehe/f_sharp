import SwiftUI

struct GradientButton: View {
    let text: String
    let gradientColors: [Color]
    let onAction: () -> Void
    
    var body: some View {
        Button(action: {
            onAction()
        }) {
            ZStack {
                VStack {
                    Spacer()
                    
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
