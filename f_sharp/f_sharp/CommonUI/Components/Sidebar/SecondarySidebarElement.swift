import SwiftUI

struct SidebarActionElement: View {
    var actionTitle: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(actionTitle)
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 5, dash: [10]))
                    .foregroundColor(.white)
            )
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
