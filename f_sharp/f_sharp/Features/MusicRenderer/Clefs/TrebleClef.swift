import SwiftUI
import PureSwiftUIDesign

private let flagLayoutConfig = LayoutGuideConfig.grid(columns: 40, rows: 48)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct TrebleClef: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for quarter-break
        let p1 = g[17, 46]
        let p2 = g[16, 40]
        let p3 = g[13, 47]
        let p4 = g[31, 42]
        let p5 = g[19, 10]
        let p6 = g[24, 5]
        let p7 = g[12, 19]
        let p8 = g[3, 27]
        let p9 = g[26, 37]
        let p10 = g[38, 30]
        let p11 = g[24, 23]
        let p12 = g[13, 30]
        let p13 = g[23, 34]
        let p14 = g[23, 27]
        let p15 = g[32, 30]
        let p16 = g[26, 35]
        let p17 = g[10, 33]
        let p18 = g[10, 25]
        let p19 = g[24, 17]
        let p20 = g[31, 7]
        let p21 = g[23, 0]
        let p22 = g[15, 10]
        let p23 = g[28, 43]
        
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        
        curves.append(
            Curve(p2,
                  g[28, 42],
                  g[17, 39]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[4, 43],
                  g[13, 47]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[34, 50],
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
                  g[20, 4],
                  p6
            )
        )
        
        curves.append(
            Curve(p7,
                  g[37, 7],
                  p7
            )
        )
        
        curves.append(
            Curve(p8,
                  g[5, 21],
                  g[2, 29]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[3, 38],
                  p9
            )
        )
        
        curves.append(
            Curve(p10,
                  g[38, 36],
                  p10
            )
        )
        
        curves.append(
            Curve(p11,
                  g[38, 22],
                  p11
            )
        )
        
        curves.append(
            Curve(p12,
                  g[9, 25],
                  p12
            )
        )
        
        curves.append(
            Curve(p13,
                  g[15, 35],
                  p13
            )
        )
        
        curves.append(
            Curve(p14,
                  g[10, 28],
                  p14
            )
        )
        
        curves.append(
            Curve(p15,
                  g[30, 26],
                  p15
            )
        )
        
        curves.append(
            Curve(p16,
                  g[32, 36],
                  p16
            )
        )
        
        curves.append(
            Curve(p17,
                  g[17, 37],
                  p17
            )
        )
        
        curves.append(
            Curve(p18,
                  g[4, 28],
                  p18
            )
        )
        
        curves.append(
            Curve(p19,
                  g[19, 19],
                  g[23, 18]
            )
        )
        
        curves.append(
            Curve(p20,
                  g[33, 10],
                  p20
            )
        )
        
        curves.append(
            Curve(p21,
                  g[31, 2],
                  p21
            )
        )
        
        curves.append(
            Curve(p22,
                  g[12, 4],
                  p22
            )
        )
        
        curves.append(
            Curve(p23,
                  g[12, 4],
                  p23
            )
        )
        
        curves.append(
            Curve(p1,
                  g[26, 48],
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

struct TrebleClefWrapper_Previews: PreviewProvider {
    struct TrebleClefWrapper: View {
        var body: some View {
            VStack {
                TrebleClef()
                    .fill(.black)
                    .frame(width: 100, height: 250)
                ZStack {
                    Image("clef")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 250)
                    TrebleClef()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 100, height: 250)
                }
            }
        }
    }
    
    static var previews: some View {
        TrebleClefWrapper()
            .showLayoutGuides(true)
    }
}
