import SwiftUI

struct DialogHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 36, weight: .heavy))
            .foregroundColor(.black)
            .padding(.top, 32)
            .padding(.bottom, 16)
    }
}
