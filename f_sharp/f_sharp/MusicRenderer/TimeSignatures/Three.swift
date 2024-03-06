import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Three: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[9, 13]
        let p2 = g[9, 15]
        let p3 = g[16, 15]
        let p4 = g[18, 17]
        let p5 = g[18, 25]
        let p6 = g[9, 25]
        let p7 = g[12, 22]
        let p8 = g[7, 18]
        let p9 = g[2, 22]
        let p10 = g[16, 29]
        let p11 = g[27, 21]
        let p12 = g[20, 14]
        let p13 = g[27, 7]
        let p14 = g[16, 0]
        let p15 = g[2, 6]
        let p16 = g[7, 10]
        let p17 = g[12, 6]
        let p18 = g[9, 3]
        let p19 = g[18, 4]
        let p20 = g[18, 11]
        let p21 = g[16, 13]
        
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
                  g[17, 15]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[19, 19],
                  g[19, 22]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[17, 28],
                  g[9, 29]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[9, 24],
                  g[12, 24]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[12, 18],
                  g[6, 18]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[8, 18],
                  g[2, 18]
            )
        )
        
        curves.append(
            Curve(p10,
                  g[2, 29],
                  g[10, 29]
            )
        )
        
        curves.append(
            Curve(p11,
                  g[27, 29],
                  g[27, 20]
            )
        )
        
        curves.append(
            Curve(p12,
                  g[27, 18],
                  g[25, 14]
            )
        )
        
        curves.append(
            Curve(p13,
                  g[25, 14],
                  g[27, 9]
            )
        )
        
        curves.append(
            Curve(p14,
                  g[27, 5],
                  g[27, 0]
            )
        )
        
        curves.append(
            Curve(p15,
                  g[10, 0],
                  g[2, 0]
            )
        )
        
        curves.append(
            Curve(p16,
                  g[2, 10],
                  g[9, 10]
            )
        )
        
        curves.append(
            Curve(p17,
                  g[5, 10],
                  g[12, 10]
            )
        )
        
        curves.append(
            Curve(p18,
                  g[12, 3],
                  g[9, 5]
            )
        )
        
        curves.append(
            Curve(p19,
                  g[9, 1],
                  g[17, 1]
            )
        )
        
        curves.append(
            Curve(p20,
                  g[19, 7],
                  g[19, 9]
            )
        )
        
        curves.append(
            Curve(p21,
                  g[17, 13],
                  p21
            )
        )
        
        curves.append(
            Curve(p1,
                  p21,
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

struct ThreeWrapper_Previews: PreviewProvider {
    struct ThreeWrapper: View {
        
        var body: some View {
            VStack {
                Three()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Three()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        ThreeWrapper()
            .showLayoutGuides(true)
    }
}
