import SwiftUI
import PureSwiftUIDesign

private let flagLayoutConfig = LayoutGuideConfig.grid(columns: 8, rows: 20)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct EighthRest: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for quarter-break
        let p1 = g[2, 3]
        let p2 = g[0, 5]
        let p3 = g[1, 7]
        let p4 = g[6, 7]
        let p5 = g[3, 17]
        let p6 = g[4, 17]
        let p7 = g[8, 4]
        let p8 = g[7, 4]
        let p9 = g[4, 6]
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[0,3],
                  p2
            )
        )
        
        curves.append(
            Curve(p3,
                  g[0,6],
                  p3
            )
        )
        
        curves.append(
            Curve(p4,
                  g[3,9],
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
                  g[4, 7],
                  p9
            )
        )
        
        curves.append(
            Curve(p1,
                  g[5, 3],
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

struct EighthRestWrapper_Previews: PreviewProvider {
    struct EighthRestWrapper: View {
        var body: some View {
            VStack {
                EighthRest()
                    .fill(.black)
                    .frame(width: 100, height: 250)
                ZStack {
                    Image("eighth-break")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 250)
                    EighthRest()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 100, height: 250)
                }
            }
        }
    }
    
    static var previews: some View {
        EighthRestWrapper()
            .showLayoutGuides(true)
    }
}
