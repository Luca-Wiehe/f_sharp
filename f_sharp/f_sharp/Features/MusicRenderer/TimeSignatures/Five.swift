import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Five: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[4, 0]
        let p2 = g[29, 0]
        let p3 = g[7, 6]
        let p4 = g[7, 12]
        let p5 = g[27, 19]
        let p6 = g[15, 29]
        let p7 = g[2, 22]
        let p8 = g[7, 19]
        let p9 = g[12, 22]
        let p10 = g[9, 26]
        let p11 = g[19, 20]
        let p12 = g[4, 15]
        
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
                  g[22, 6],
                  g[10, 7]
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
                  g[12, 8],
                  g[27, 10]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[27, 28],
                  g[20, 29]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[0, 29],
                  g[2, 23]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[2, 21],
                  g[2, 19]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[12, 19],
                  g[12, 22]
            )
        )
        
        curves.append(
            Curve(p10,
                  g[12, 25],
                  g[9, 24]
            )
        )
        
        curves.append(
            Curve(p11,
                  g[9, 28],
                  g[19, 31]
            )
        )
        
        curves.append(
            Curve(p12,
                  g[19, 15],
                  g[16, 9]
            )
        )
        
        curves.append(
            Curve(p1,
                  p12,
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

struct FiveWrapper_Previews: PreviewProvider {
    struct FiveWrapper: View {
        
        var body: some View {
            VStack {
                Five()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-5")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Five()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        FiveWrapper()
            .showLayoutGuides(true)
    }
}
