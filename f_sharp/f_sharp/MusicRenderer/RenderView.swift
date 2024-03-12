import SwiftUI

struct RenderView: View {
    let lineHeight: CGFloat
    let lineSpacing: CGFloat
    
    let pattern: String
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines(lineSpacing: lineSpacing, lineHeight: lineHeight)
            EighthRest()
                .frame(width: 1.25 * lineSpacing, height: 2.5 * lineSpacing)
                .offset(x: 200)
            QuarterRest()
                .frame(width: 1.25 * lineSpacing, height: 2.5 * lineSpacing)
                .offset(x: 150)
            Note(noteSize: CGSize(width: 26, height: 26), isCutout: false, stemType: 2, flagType: 2)
                .frame(width: 50, height: 100)
                .offset(x: 80, y: 67)
            TrebleClef()
                .frame(width: 2.5 * lineSpacing, height: 6 * lineSpacing)
                .offset(x: 10)
            BassClef()
                .frame(width: 3 * (lineHeight + lineSpacing) / 1.1905, height: 3 * (lineHeight + lineSpacing))
                .offset(x: 250, y: -8)
            Rectangle()
                .frame(width: lineSpacing * 1.5, height: lineSpacing / 2)
                .offset(x: 350, y: -lineSpacing / 4)
            Rectangle()
                .frame(width: lineSpacing * 1.5, height: lineSpacing / 2)
                .offset(x: 400, y: -lineSpacing * 3 / 4)
            TimeSignature(beatsPerMeasure: 4, beatType: 4)
                .frame(width: 4 * lineSpacing / 1.1905, height: 4 * lineSpacing - 4)
                .offset(x: 450)
        }
        .frame(height: 200)
    }
}

#Preview {
    RenderView(lineHeight: 1, lineSpacing: 20, pattern: "")
}
      
