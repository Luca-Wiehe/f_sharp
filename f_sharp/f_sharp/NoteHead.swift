import SwiftUI

struct MyView: View {
    var body: some View {
        TwoEllipsesShape(isCutout: true)
            .fill(Color.primary) // Apply fill first to fill the shape.
            .overlay( // Then overlay the stroke on top of the filled shape.
                TwoEllipsesShape(isCutout: true)
                    .stroke(Color.black, lineWidth: 2)
            )
            .frame(width: 200, height: 200)
    }
}

struct TwoEllipsesShape: Shape {
    var isCutout: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the rectangles for the outer and inner ellipses.
        let outerEllipseRect = CGRect(x: rect.minX + 25, y: rect.minY + 10, width: rect.width - 50, height: rect.height - 20)
        let innerEllipseRect = outerEllipseRect.insetBy(dx: 40, dy: 20)
        
        // Add the outer ellipse to the path.
        path.addEllipse(in: outerEllipseRect)
        
        // Create the inner ellipse path.
        var innerPath = Path()
        innerPath.addEllipse(in: innerEllipseRect)
        
        // Cut out the inner ellipse from the outer one if isCutout is true.
        if isCutout {
            path = path.subtracting(innerPath)
        } else {
            path.addPath(innerPath)
        }
        
        // Apply the rotation around the center of the path.
        let transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180))
        path = path.applying(transform)
        
        // Calculate the offset needed to center the path in the original rect.
        let boundingBox = path.boundingRect
        let offsetX = (rect.width - boundingBox.width) / 2 - boundingBox.minX
        let offsetY = (rect.height - boundingBox.height) / 2 - boundingBox.minY
        
        // Apply the offset to the path to center it in the frame.
        path = path.offsetBy(dx: offsetX, dy: offsetY)
        
        return path
    }
}

// Preview
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
