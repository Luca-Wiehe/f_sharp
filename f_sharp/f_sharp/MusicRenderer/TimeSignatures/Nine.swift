import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Nine: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[15, 0]
        let p2 = g[27, 15]
        let p3 = g[15, 29]
        let p4 = g[3, 23]
        let p5 = g[8, 19]
        let p6 = g[13, 23]
        let p7 = g[9, 26]
        let p8 = g[19, 26]
        let p9 = g[19, 15]
        let p10 = g[3, 8]
        
        // create outer path for 9 using Bezier Curves
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[29, 0],
                  g[27, 13]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[27, 29],
                  g[18, 29]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[2, 29],
                  g[3, 24]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[3, 22],
                  g[4, 19]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[12, 19],
                  g[13, 22]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[13, 26],
                  g[9, 24]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[9, 28],
                  g[17, 29]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[21, 23],
                  p9
            )
        )
        
        curves.append(
            Curve(p10,
                  g[2, 18],
                  g[3, 10]
            )
        )
        
        curves.append(
            Curve(p1,
                  g[3, 6],
                  g[3, 0]
            )
        )
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        // define path for inner capsule of "9"
        let capsuleWidth: CGFloat = rect.width * 8 / 30
        let capsuleHeight: CGFloat = rect.height * 13 / 29
        
        let capsuleCenterX = rect.minX + (rect.width * 15 / 30)
        let capsuleCenterY = rect.minY + (rect.height * 8 / 29)
        
        // Create a capsule-like rounded rectangle path
        var capsulePath = Path()
        let capsuleRect = CGRect(x: capsuleCenterX - capsuleWidth / 2, y: capsuleCenterY - capsuleHeight / 2, width: capsuleWidth, height: capsuleHeight)
        capsulePath.addRoundedRect(in: capsuleRect, cornerSize: CGSize(width: capsuleHeight / 2, height: capsuleHeight / 2))
        
        // Subtract the capsule path from the original path
        path = path.subtracting(capsulePath)
        
        return path
    }
}

struct NineWrapper_Previews: PreviewProvider {
    struct NineWrapper: View {
        
        var body: some View {
            VStack {
                Nine()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-9")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Nine()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        NineWrapper()
            .showLayoutGuides(true)
    }
}
