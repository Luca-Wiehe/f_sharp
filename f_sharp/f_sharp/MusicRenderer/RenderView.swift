import SwiftUI

struct RenderView: View {
    let noteLine: Int
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines()
            Note(noteSize: CGSize(width: 26, height: 26), isCutout: false, stemType: 2, flagType: 2)
                .offset(x: 80)
            Clef()
                .frame(width: 50, height: 125)
                .offset(x: 10)
        }
        .frame(height: 200)
    }
}

#Preview {
    RenderView(noteLine: 1)
}
