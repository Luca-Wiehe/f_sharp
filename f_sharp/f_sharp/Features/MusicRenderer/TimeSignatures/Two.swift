import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Two: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[0, 29]
        let p2 = g[20, 8]
        let p3 = g[8, 5]
        let p4 = g[12, 9]
        let p5 = g[7, 14]
        let p6 = g[1, 8]
        let p7 = g[15, 0]
        let p8 = g[29, 8]
        let p9 = g[9, 20]
        let p10 = g[28, 18]
        let p11 = g[19, 29]
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[0, 17],
                  g[20, 15]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[20, 0],
                  g[8, 0]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[8, 6],
                  g[12, 6]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[12, 11],
                  g[10, 14]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[2, 14],
                  g[1, 10]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[1, 6],
                  g[1, 0]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[30, 0],
                  g[29, 6]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[29, 18],
                  g[9, 17]
            )
        )
        
        curves.append(
            Curve(p10,
                  g[20, 18],
                  g[22, 26]
            )
        )
        
        curves.append(
            Curve(p11,
                  p10,
                  g[27, 29]
            )
        )
        
        curves.append(
            Curve(p1,
                  g[8, 29],
                  g[10, 24]
            )
        )
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        return path
    }
}

struct TwoWrapper_Previews: PreviewProvider {
    struct TwoWrapper: View {
        
        var body: some View {
            VStack {
                Two()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 315, height: 375)
                    Two()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        TwoWrapper()
            .showLayoutGuides(true)
    }
}
