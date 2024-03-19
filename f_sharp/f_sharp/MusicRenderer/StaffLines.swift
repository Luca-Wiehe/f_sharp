import SwiftUI

struct StaffLines: View {
    @Environment(\.colorScheme) var colorScheme
    
    let numberOfLines = 5
    let lineSpacing: CGFloat
    let lineHeight: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let totalHeight = CGFloat(numberOfLines - 1) * lineSpacing
                
                let startY = (geometry.size.height - totalHeight) / 2
                
                for lineIndex in 0..<numberOfLines {
                    let y = startY + CGFloat(lineIndex) * lineSpacing
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: lineHeight, lineCap: .round))
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct StaffLines_Preview: PreviewProvider {
    static var previews: some View {
        StaffLines(lineSpacing: 20, lineHeight: 1)
            .frame(height: 100)
    }
}
