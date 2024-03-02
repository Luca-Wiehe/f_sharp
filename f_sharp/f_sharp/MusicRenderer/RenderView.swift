import SwiftUI

struct RenderView: View {
    let noteLine: Int
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines()
            Note(noteSize: CGSize(width: 26, height: 26), isCutout: false, stemType: 2, flagType: 2)
                .offset(x: 20, y: 7)
        }
        .frame(height: 100)
    }
}

#Preview {
    RenderView(noteLine: 1)
}
