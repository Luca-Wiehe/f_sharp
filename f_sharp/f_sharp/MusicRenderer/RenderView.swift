import SwiftUI

struct RenderView: View {
    let noteLine: Int
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines()
            EighthBreak()
                .frame(width: 25, height: 50)
                .offset(x: 200)
            QuarterBreak()
                .frame(width: 25, height: 50)
                .offset(x: 150)
            Note(noteSize: CGSize(width: 26, height: 26), isCutout: false, stemType: 2, flagType: 2)
                .frame(width: 50, height: 100)
                .offset(x: 80, y: 67)
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
