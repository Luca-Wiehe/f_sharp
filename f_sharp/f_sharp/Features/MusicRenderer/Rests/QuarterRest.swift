import SwiftUI
import PureSwiftUIDesign

private let flagLayoutConfig = LayoutGuideConfig.grid(columns: 20, rows: 25)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct QuarterRest: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for quarter-rest
        let p1 = g[5, 0]
        let p2 = g[8, 0]
        let p3 = g[18, 7]
        let p4 = g[18, 18]
        let p5 = g[17, 19]
        let p6 = g[11, 24]
        let p7 = g[10, 25]
        let p8 = g[13, 17]
        let p9 = g[3, 10]
        
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
                  g[4, 13],
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
                  g[2, 16],
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
                  g[-10, 14],
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
            Curve(p1,
                  g[15, 5],
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

struct QuarterRestWrapper_Previews: PreviewProvider {
    struct QuarterRestWrapper: View {
        var body: some View {
            VStack {
                QuarterRest()
                    .fill(.black)
                    .frame(width: 100, height: 250)
                ZStack {
                    Image("quarter-break")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 250)
                    QuarterRest()
                        .stroke(Color.black, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 100, height: 250)
                }
            }
        }
    }
    
    static var previews: some View {
        QuarterRestWrapper()
            .showLayoutGuides(true)
    }
}
