import SwiftUI
import PureSwiftUIDesign

private var flagLayoutConfig:  LayoutGuideConfig = LayoutGuideConfig.grid(columns: 30, rows: 29)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct Eight: Shape {
    /**
     Expected aspect ratio: 1 : 1.1905
     */
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for digit
        let p1 = g[3, 7]
        let p2 = g[15, 0]
        let p3 = g[26, 6]
        let p4 = g[22, 13]
        let p5 = g[28, 20]
        let p6 = g[15, 29]
        let p7 = g[2, 22]
        let p8 = g[6, 13]
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2,
                  g[3, 5],
                  g[2, 0]
            )
        )
        
        curves.append(
            Curve(p3,
                  g[28, 0],
                  g[26, 4]
            )
        )
        
        curves.append(
            Curve(p4,
                  g[26, 11],
                  g[23, 11]
            )
        )
        
        curves.append(
            Curve(p5,
                  g[29, 16],
                  g[28, 18]
            )
        )
        
        curves.append(
            Curve(p6,
                  g[28, 22],
                  g[25, 29]
            )
        )
        
        curves.append(
            Curve(p7,
                  g[6, 29],
                  g[2, 24]
            )
        )
        
        curves.append(
            Curve(p8,
                  g[1, 15],
                  g[6, 16]
            )
        )
        
        curves.append(
            Curve(p1,
                  g[3, 11],
                  g[3, 9]
            )
        )
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        var upperCutoutPath = Path()
        var upperCurves = [Curve]()
        
        let upper_p1 = g[10, 5]
        let upper_p2 = g[16, 1]
        let upper_p3 = g[24, 6]
        let upper_p4 = g[20, 12]
        
        upperCurves.append(
            Curve(upper_p2,
                  g[10, 4],
                  g[9, 1]
            )
        )
        
        upperCurves.append(
            Curve(upper_p3,
                  g[23, 1],
                  g[24, 4]
            )
        )
        
        upperCurves.append(
            Curve(upper_p4,
                  g[24, 8],
                  upper_p4
            )
        )
        
        upperCurves.append(
            Curve(upper_p1,
                  g[9, 8],
                  g[10, 6]
            )
        )
        
        upperCutoutPath.move(upper_p1)
        
        for curve in upperCurves {
            upperCutoutPath.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        path = path.subtracting(upperCutoutPath)
        
        var lowerCutoutPath = Path()
        var lowerCurves = [Curve]()
        
        let lower_p1 = g[4, 20]
        let lower_p2 = g[9, 14]
        let lower_p3 = g[21, 22]
        let lower_p4 = g[14, 28]
        
        lowerCurves.append(
            Curve(lower_p2,
                  g[4, 18],
                  lower_p2
            )
        )
        
        lowerCurves.append(
            Curve(lower_p3,
                  lower_p2,
                  g[21, 19]
            )
        )
        
        lowerCurves.append(
            Curve(lower_p4,
                  g[21, 26],
                  g[16, 28]
            )
        )
        
        lowerCurves.append(
            Curve(lower_p1,
                  g[10, 28],
                  g[4, 24]
            )
        )
        
        lowerCutoutPath.move(lower_p1)
        
        for curve in lowerCurves {
            lowerCutoutPath.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        path = path.subtracting(lowerCutoutPath)
        
        return path
    }
}

struct EightWrapper_Previews: PreviewProvider {
    struct EightWrapper: View {
        
        var body: some View {
            VStack {
                Eight()
                    .fill(.black)
                    .frame(width: 315, height: 375)
                
                Spacer()
                
                ZStack {
                    Image("digit-8")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 315, height: 375)
                    Eight()
                        .stroke(Color.red, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 315, height: 375)
                }
            }
        }
    }
    
    static var previews: some View {
        EightWrapper()
            .showLayoutGuides(true)
    }
}
