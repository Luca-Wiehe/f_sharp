import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 30)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct BassClef: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for eighth-break
        let p1 = g[0, 8]
        let p2 = g[11, 0]
        let p3 = g[23, 10]
        let p4 = g[0, 30]
        let p5 = g[17, 10]
        let p6 = g[10, 2]
        let p7 = g[3, 6]
        let p8 = g[6, 6]
        let p9 = g[10, 9]
        let p10 = g[6, 12]
        
        let cellWidth = rect.width / 30
        let radius = cellWidth * 2.5  // Radius of two grid cells
        
        // Center points for the circles
        let center1 = g[27, 5]
        let center2 = g[27, 13]
        
        // Since addEllipse(in:) requires a CGRect, calculate the CGRect for each circle
        let circle1Rect = CGRect(x: center1.x - radius, y: center1.y - radius, width: radius * 2, height: radius * 2)
        let circle2Rect = CGRect(x: center2.x - radius, y: center2.y - radius, width: radius * 2, height: radius * 2)
        
        // Add circles to the path
        path.addEllipse(in: circle1Rect)
        path.addEllipse(in: circle2Rect)
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[0, 0],
                  p2
            )
        )
        
        curves.append(
            Curve(p3,
                  g[23, 0],
                  p3
            )
        )
        
        curves.append(
            Curve(p4,
                  g[23, 23],
                  p4
            )
        )
        
        curves.append(
            Curve(p5,
                  g[13, 23],
                  g[17, 12]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[17, 6],
                  g[15, 3]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[5, 1],
                  g[2, 5]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[4, 7],
                  p8
            )
        )
        
        curves.append(
            Curve(p9,
                  g[10, 6],
                  p9
            )
        )
        
        curves.append(
            Curve(p10,
                  g[10, 12],
                  p10
            )
        )
        
        curves.append(
            Curve(p1,
                  g[0, 12],
                  p1
            )
        )
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        return path
    }
}

struct BassClefWrapper_Previews: PreviewProvider {
    struct BassClefWrapper: View {
        
        var body: some View {
            VStack {
                BassClef()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("bass-clef")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 315, height: 375)
                    BassClef()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        BassClefWrapper()
            .showLayoutGuides(true)
    }
}
