import SwiftUI

struct StaffLinesView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let numberOfLines = 5
    let lineSpacing: CGFloat = 20
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Calculate the total height needed for all lines and spacings
                let totalHeight = CGFloat(numberOfLines - 1) * lineSpacing
                
                // Starting y-position for the first line
                let startY = (geometry.size.height - totalHeight) / 2
                
                // Draw each of the staff lines
                for lineIndex in 0..<numberOfLines {
                    let y = startY + CGFloat(lineIndex) * lineSpacing
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

struct StaffLinesView_Previews: PreviewProvider {
    static var previews: some View {
        StaffLinesView()
            .frame(height: 100) // Set an appropriate height for the staff lines to display correctly
    }
}

