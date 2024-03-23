import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Six: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[15, 29]
        let p2 = g[3, 14]
        let p3 = g[15, 0]
        let p4 = g[27, 6]
        let p5 = g[22, 10]
        let p6 = g[17, 6]
        let p7 = g[21, 3]
        let p8 = g[11, 3]
        let p9 = g[11, 14]
        let p10 = g[27, 21]
        
        // create outer path for 9 using Bezier Curves
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[1, 29],
                  g[3, 16]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[3, 0],
                  g[11, 0]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[28, 0],
                  g[27, 5]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[27, 7],
                  g[26, 10]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[18, 10],
                  g[17, 7]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[17, 3],
                  g[21, 5]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[21, 1],
                  g[13, 0]
            )
        )
        
        curves.append(
            Curve(p9,
                  g[9, 6],
                  p9
            )
        )
        
        curves.append(
            Curve(p10,
                  g[28, 11],
                  g[27, 19]
            )
        )
        
        curves.append(
            Curve(p1,
                  g[27, 23],
                  g[27, 29]
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
        let capsuleCenterY = rect.minY + (rect.height * 21 / 29)
        
        // Create a capsule-like rounded rectangle path
        var capsulePath = Path()
        let capsuleRect = CGRect(x: capsuleCenterX - capsuleWidth / 2, y: capsuleCenterY - capsuleHeight / 2, width: capsuleWidth, height: capsuleHeight)
        capsulePath.addRoundedRect(in: capsuleRect, cornerSize: CGSize(width: capsuleHeight / 2, height: capsuleHeight / 2))
        
        // Subtract the capsule path from the original path
        path = path.subtracting(capsulePath)
        
        return path
    }
}

struct SixWrapper_Previews: PreviewProvider {
    struct SixWrapper: View {
        
        var body: some View {
            VStack {
                Six()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-6")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Six()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        SixWrapper()
            .showLayoutGuides(true)
    }
}
