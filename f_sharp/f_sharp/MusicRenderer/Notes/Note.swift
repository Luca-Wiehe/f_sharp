import SwiftUI

struct Note: Shape {
    var noteSize: CGSize
    var isCutout: Bool = false
    var stemType: Int // 0: no stem, 1: stem up, 2: stem down
    var flagType: Int // 0: no flag, 1: single flag, 2: double flag

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // NoteHead
        let noteHead = NoteHead(isCutout: isCutout)
        let noteHeadRect = CGRect(x: rect.midX,
                                  y: rect.maxY,
                                  width: noteSize.width,
                                  height: noteSize.height)
        path.addPath(noteHead.path(in: noteHeadRect))
        
        // Stem drawing
        let stemWidth = noteSize.width * 0.1
        let stemHeight = noteSize.height * 3
        var stemRect = CGRect.zero
        
        if stemType == 1 {
            let stemXPosition: CGFloat = rect.minX + noteSize.width - stemWidth
            
            stemRect = CGRect(x: stemXPosition,
                              y: rect.midY - 1.4 * noteSize.height - stemHeight,
                              width: stemWidth,
                              height: stemHeight)
            path.addRect(stemRect)
        } else if stemType == 2 {
            let stemXPosition: CGFloat = rect.minX + stemWidth
            
            stemRect = CGRect(x: stemXPosition,
                              y: rect.midY - 1.4 * noteSize.height,
                              width: stemWidth,
                              height: stemHeight)
            path.addRect(stemRect)
        }
        
        // Flag drawing
        if flagType == 1 {
            
            let flagHeight = stemHeight / 1.5
            let flagWidth = noteSize.width * 0.6
            let flagRect: CGRect
            var flag: NoteFlag
            
            if stemType == 1 {
                // Stem up
                flag = NoteFlag()
                flagRect = CGRect(x: stemRect.maxX,
                                  y: stemRect.minY,
                                  width: flagWidth,
                                  height: flagHeight)
                path.addPath(flag.path(in: flagRect))
            } else {
                // Stem down
                flag = NoteFlag()
                flagRect = CGRect(x: stemRect.minX + stemWidth,
                                  y: stemRect.maxY - flagHeight,
                                  width: flagWidth,
                                  height: flagHeight)
                
                let flipTransform = CGAffineTransform(scaleX: 1, y: -1)
                    .translatedBy(x: 0, y: -(flagRect.minY + flagRect.maxY))
                path.addPath(flag.path(in: flagRect).applying(flipTransform))
            }
        }
        
        else if flagType == 2 {
            let flag1 = NoteFlag()
            let flag2 = NoteFlag()
            
            let flagHeight = stemHeight / 1.5
            let flagWidth = noteSize.width * 0.6
            let flag1Rect: CGRect
            let flag2Rect: CGRect
            
            if stemType == 1 {
                // Stem up
                flag1Rect = CGRect(x: stemRect.maxX,
                                  y: stemRect.minY,
                                  width: flagWidth,
                                  height: flagHeight)
                
                flag2Rect = CGRect(x: stemRect.maxX,
                                   y: stemRect.minY + noteSize.height / 1.5,
                                  width: flagWidth,
                                  height: flagHeight)
                
                path.addPath(flag1.path(in: flag1Rect))
                path.addPath(flag2.path(in: flag2Rect))
            } else {
                // Stem down
                flag1Rect = CGRect(x: stemRect.maxX,
                                  y: stemRect.maxY - flagHeight,
                                  width: flagWidth,
                                  height: flagHeight)
                flag2Rect = CGRect(x: stemRect.maxX,
                                   y: stemRect.maxY - flagHeight - noteSize.height / 1.5,
                                  width: flagWidth,
                                  height: flagHeight)
                
                let flipTransform1 = CGAffineTransform(scaleX: 1, y: -1)
                    .translatedBy(x: 0, y: -(flag1Rect.minY + flag1Rect.maxY))
                let flipTransform2 = CGAffineTransform(scaleX: 1, y: -1)
                    .translatedBy(x: 0, y: -(flag2Rect.minY + flag2Rect.maxY))
                
                path.addPath(flag1.path(in: flag1Rect).applying(flipTransform1))
                path.addPath(flag2.path(in: flag2Rect).applying(flipTransform2))
            }
        }
        
        return path
    }
}

#Preview {
    Note(noteSize: CGSize(20, 20), stemType: 1, flagType: 2)
        .frame(width: 20, height: 60)
        .background(.red)
}
