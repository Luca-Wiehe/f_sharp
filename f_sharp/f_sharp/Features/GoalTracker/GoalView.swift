import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct GoalView: View {
    @EnvironmentObject var popupManager: PopupManager
    
    var body: some View {
        VStack(spacing: 0) {
            Image("piano")
                .resizable()
                .scaledToFill()
                .frame(height: 350)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            
            ZStack {
                // Background
                Color.purple
                
                // Text and Button
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Shape your Journey")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(0.7))
                        Text("Set Goals")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: {
                        popupManager.isShown = true
                        popupManager.content = AnyView(GoalPopup())
                    }) {
                        Text("Open")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(30)
                    }
                }
                .padding()
            }
            .frame(height: 100)
        }
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
