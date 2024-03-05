import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 30)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Four: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for eighth-break
        let p1 = g[11, 0]
        let p2 = g[24, 0]
        let p3 = g[4, 20]
        let p4 = g[15, 20]
        let p5 = g[15, 12]
        let p6 = g[24, 4]
        let p7 = g[24, 20]
        let p8 = g[29, 20]
        let p9 = g[29, 22]
        let p10 = g[24, 22]
        let p11 = g[24, 27]
        let p12 = g[27, 28]
        let p13 = g[27, 30]
        let p14 = g[12, 30]
        let p15 = g[12, 28]
        let p16 = g[15, 27]
        let p17 = g[15, 22]
        let p18 = g[2, 22]
        let p19 = g[0, 20]
        
        let cellWidth = rect.width / 30
        let radius = cellWidth * 2.5  // Radius of two grid cells
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  p1,
                  p2
            )
        )
        
        curves.append(
            Curve(p3,
                  p2,
                  p3
            )
        )
        
        curves.append(
            Curve(p4,
                  p3,
                  p4
            )
        )
        
        curves.append(
            Curve(p5,
                  p4,
                  p5
            )
        )
        
        curves.append(
            Curve(p6,
                  p5,
                  p6
            )
        )
        
        curves.append(
            Curve(p7,
                  p6,
                  p7
            )
        )
        
        curves.append(
            Curve(p8,
                  p7,
                  p8
            )
        )
        
        curves.append(
            Curve(p9,
                  p8,
                  p9
            )
        )
        
        curves.append(
            Curve(p10,
                  p9,
                  p10
            )
        )
        
        curves.append(
            Curve(p11,
                  p10,
                  p11
            )
        )
        
        curves.append(
            Curve(p12,
                  g[24, 28],
                  p12
            )
        )
        
        curves.append(
            Curve(p13,
                  p12,
                  p13
            )
        )
        
        curves.append(
            Curve(p14,
                  p13,
                  p14
            )
        )
        
        curves.append(
            Curve(p15,
                  p14,
                  p15
            )
        )
        
        curves.append(
            Curve(p16,
                  g[15, 28],
                  p16
            )
        )
        
        curves.append(
            Curve(p17,
                  p16,
                  p17
            )
        )
        
        curves.append(
            Curve(p18,
                  p17,
                  p18
            )
        )
        
        curves.append(
            Curve(p19,
                  g[0, 21],
                  g[-1, 21]
            )
        )
        
        curves.append(
            Curve(p1,
                  g[11, 10],
                  p1
            )
        )
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: true)
        }
        
        return path
    }
}

struct FourWrapper_Previews: PreviewProvider {
    struct FourWrapper: View {
        
        var body: some View {
            VStack {
                Four()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-4")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 315, height: 375)
                    Four()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        FourWrapper()
            .showLayoutGuides(true)
    }
}
