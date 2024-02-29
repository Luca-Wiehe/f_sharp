import SwiftUI

struct PopupComponent<Content: View>: View {
    @Binding var isShown: Bool
    let content: () -> Content
    
    var body: some View {
        if isShown {
            ZStack {
                Color.black.opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isShown = false
                    }
                
                VStack {
                    self.content()
                }
                .fixedSize(horizontal: false, vertical: true) // width fixed, height fit-content
                .frame(maxWidth: 600)
                .padding(40)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(30)
                .shadow(radius: 20)
                .overlay(
                    Button(action: {
                        self.isShown = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color(UIColor.secondarySystemFill))
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 20),
                    alignment: .topTrailing
                )
                .transition(.scale)
            }
        }
    }
}
