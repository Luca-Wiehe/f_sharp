import SwiftUI

struct PrimarySidebarElement: View {
    let isExpandable: Bool
    let icon: String
    let text: String
    @Binding var isExpanded: Bool

    var body: some View {
        Button(action: {
            if isExpandable {
                self.isExpanded.toggle()
            }
        }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(.leading, 24)

                Text(text)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .padding(.vertical, isExpandable ? 16 : 0)
                
                Spacer()
                
                if isExpandable {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.trailing, 16)
                }
            }
        }
    }
}
