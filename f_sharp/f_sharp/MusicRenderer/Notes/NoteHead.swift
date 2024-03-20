import SwiftUI

struct NoteHead: Shape {
    /**
     Expecting 1:1 aspect ratio
     */
    var isCutout: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Calculate proportions based on the rect's size.
        let marginHorizontal = rect.width * 0.125
        let marginVertical = rect.height * 0.05
        let innerInsetHorizontal = rect.width * 0.2
        let innerInsetVertical = rect.height * 0.1
        
        // Defining bounding boxes for rectangles
        let outerEllipseRect = CGRect(x: rect.minX,
                                      y: rect.minY,
                                      width: rect.width - 2 * marginHorizontal,
                                      height: rect.height + 4 * marginVertical)
        let innerEllipseRect = outerEllipseRect.insetBy(dx: innerInsetHorizontal, dy: innerInsetVertical)
        
        // Add the outer ellipse to the path.
        path.addEllipse(in: outerEllipseRect)
        
        // Create the inner ellipse path.
        var innerPath = Path()
        innerPath.addEllipse(in: innerEllipseRect)
        
        // Cut out the inner ellipse from the outer one if isCutout is true, or add it otherwise.
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

#Preview {
    NoteHead(isCutout: true)
        .frame(width: 300, height: 300)
}
