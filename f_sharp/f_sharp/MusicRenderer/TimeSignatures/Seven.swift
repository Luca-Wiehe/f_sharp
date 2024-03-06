import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Seven: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[1, 0]
        let p2 = g[12, 0]
        let p3 = g[27, 1]
        let p4 = g[29, 2]
        let p5 = g[17, 29]
        let p6 = g[7, 29]
        let p7 = g[21, 9]
        let p8 = g[5, 7]
        let p9 = g[1, 11]
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[5, 5],
                  g[6, 0]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[18, 0],
                  g[23, 9]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[28, 0],
                  g[29, 1]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[29, 8],
                  g[18, 18]
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
                  g[7, 18],
                  g[27, 9]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[14, 9],
                  g[13, 12]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[4, 6],
                  p9
            )
        )
        
        curves.append(
            Curve(p1,
                  p9,
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

struct SevenWrapper_Previews: PreviewProvider {
    struct SevenWrapper: View {
        
        var body: some View {
            VStack {
                Seven()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Seven()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        SevenWrapper()
            .showLayoutGuides(true)
    }
}
