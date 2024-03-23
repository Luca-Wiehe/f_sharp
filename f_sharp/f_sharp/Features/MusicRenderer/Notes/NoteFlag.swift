import SwiftUI
import PureSwiftUIDesign

private let flagLayoutConfig = LayoutGuideConfig.grid(columns: 9, rows: 6)

private typealias Curve = (p: CGPoint, cp1: CGPoint, cp2: CGPoint)

struct NoteFlag: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let g = flagLayoutConfig.layout(in: rect)
        
        // checkpoints for flag
        let p1 = g[0, 0]
        let p2 = g[8, 4]
        let p3 = g[5, 6]
        let p4 = g[0, 2]
        
        // draw bezier curves between checkpoints
        var curves = [Curve]()
        
        curves.append(
            Curve(p2, 
                  g[1, 2],
                  g[8, 2]
            )
        )
        
        curves.append(
            Curve(p3, 
                  g[8, 5],
                  p3
            )
        )
        
        curves.append(
            Curve(p4, 
                  g[11, 3],
                  g[3, 2]
            )
        )
        
        curves.append(Curve(p1, p4, p1))
        
        path.move(p1)
        
        for curve in curves {
            path.curve(curve.p, cp1: curve.cp1, cp2: curve.cp2, showControlPoints: false)
        }
        
        return path
    }
}

struct NoteFlagWrapper_Previews: PreviewProvider {
    struct NoteFlagWrapper: View {
        var body: some View {
            VStack {
                NoteFlag()
                    .fill(.black)
                    .frame(width: 100, height: 250)
                ZStack {
                    Image("eigth")
                    NoteFlag()
                        .stroke(Color.black, lineWidth: 2)
                        .layoutGuide(flagLayoutConfig)
                        .frame(width: 100, height: 250)
                }
            }
        }
    }
    
    static var previews: some View {
        NoteFlagWrapper()
            .showLayoutGuides(true)
    }
}
