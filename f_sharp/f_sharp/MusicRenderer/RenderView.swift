import SwiftUI

struct RenderView: View {
    let noteLine: Int
    let lineHeight: CGFloat
    let lineSpacing: CGFloat
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines(lineSpacing: 20)
            EighthBreak()
                .frame(width: 25, height: 50)
                .offset(x: 200)
            QuarterBreak()
                .frame(width: 25, height: 50)
                .offset(x: 150)
            Note(noteSize: CGSize(width: 26, height: 26), isCutout: false, stemType: 2, flagType: 2)
                .frame(width: 50, height: 100)
                .offset(x: 80, y: 67)
            TrebleClef()
                .frame(width: 50, height: 125)
                .offset(x: 10)
            BassClef()
                .frame(width: 3.25 * lineSpacing / 1.1905, height: 3.25 * lineSpacing)
                .offset(x: 250, y: -0.5 * lineSpacing + lineHeight)
        }
        .frame(height: 200)
    }
}

#Preview {
    RenderView(noteLine: 1, lineHeight: 2, lineSpacing: 20)
}
