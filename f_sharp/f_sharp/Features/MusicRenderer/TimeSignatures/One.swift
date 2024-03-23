import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct One: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[11, 1]
        let p2 = g[20, 1]
        let p3 = g[20, 24]
        let p4 = g[27, 28]
        let p5 = g[27, 29]
        let p6 = g[5, 29]
        let p7 = g[5, 28]
        let p8 = g[12, 24]
        let p9 = g[12, 5]
        let p10 = g[6, 15]
        let p11 = g[3, 15]
        
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
                  g[20, 27],
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
                  g[12, 27]
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
            Curve(p1,
                  p11,
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

struct OneWrapper_Previews: PreviewProvider {
    struct OneWrapper: View {
        
        var body: some View {
            VStack {
                One()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    One()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        OneWrapper()
            .showLayoutGuides(true)
    }
}
