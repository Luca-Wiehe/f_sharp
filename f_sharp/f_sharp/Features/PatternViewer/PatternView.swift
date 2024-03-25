import SwiftUI

struct PatternView: View {
    var onEdit: () -> Void

    var body: some View {
        VStack {
            RenderView(lineHeight: 2, lineSpacing: 20, pattern: "")
                .padding(.horizontal, 16)
            Spacer()
            PatternActionsView(onEdit: onEdit)
        }
    }
}

struct PatternActionsView: View {
    var onEdit: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 35, style: .continuous)
                .foregroundColor(.blue)
                .frame(width: 300, height: 64)

            HStack(spacing: 28) {
                // Play button
                Button(action: {
                    // play MIDI of pattern
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
                    onEdit()
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
                    // show PatternStatisticsView
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
        .padding(.bottom, 32)
    }
}
