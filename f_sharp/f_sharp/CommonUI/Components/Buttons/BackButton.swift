import SwiftUI

struct BackButton: View {
    var action: () -> Void
    var color: Color = .blue

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(color)
        }
    }
}
