import SwiftUI

struct PatternView: View {
    var patternText: String

    var body: some View {
        VStack {
            RenderView(lineHeight: 2, lineSpacing: 20)
                .padding(.horizontal, 16)
            Spacer()
            PatternActionsView()
        }
    }
}

struct PatternActionsView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .foregroundColor(.blue)
                .frame(width: 300, height: 64)

            // Button group without forcing full width
            HStack(spacing: 28) {
                // Play button
                Button(action: {
                    // Handle play action
                }) {
                    VStack {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        Text("Play")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }

                // Edit button (larger and emphasized)
                Button(action: {
                    // Handle edit action
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 48))
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                }

                // Statistics button
                Button(action: {
                    // Handle statistics action
                }) {
                    VStack {
                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                        Text("Statistics")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                }
            }
        }
    }
}


#Preview {
    PatternView(patternText: "Pattern 1")
}
