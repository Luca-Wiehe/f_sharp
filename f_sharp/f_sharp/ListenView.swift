import SwiftUI

struct ListenView: View {    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Listen")
                    .font(.system(size: 48, weight: .heavy, design: .default))
                    .padding(32)
                Spacer()
            }
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    ListenView()
}
