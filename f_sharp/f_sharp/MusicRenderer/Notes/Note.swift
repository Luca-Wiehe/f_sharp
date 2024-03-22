import SwiftUI

/** 
 `NoteConfig` encapsulates configuration parameters for rendering musical notes in a graphical interface. It provides a flexible way to define the geometric relationships between the note head, stem, and flags, ensuring scalable and visually consistent representations of musical notes across various sizes.
 
 Properties within `NoteConfig` are ratios that determine the size of the note head, flags and stems relative to each other. Adjusting these ratios allows for customization of the note's appearance, catering to different stylistic needs or graphical contexts.
*/
struct NoteConfig {
    let stemToHeadWidthRatio: CGFloat = 0.1
    let stemToHeadHeightRatio: CGFloat = 3
    let flagToHeadWidthRatio: CGFloat = 0.6
    let flagToStemHeightRatio: CGFloat = 0.67
    let stemToHeadYOffset: CGFloat = 0.2
}

/**
 A Shape for rendering a musical note in SwiftUI, allowing customization of size, duration, stem, and flag appearance.

 This struct provides a flexible way to draw musical notes with various characteristics determined by the note's duration and specific attributes such as whether the note head is cut out, the direction of the stem, and the number of flags.

 Usage Example:
 ---------------
 To create a quarter note with a specific size:
 ```
 Note(noteSize: CGSize(width: 20, height: 20), noteDuration: .quarter)
    .frame(width: 20, height: 20)
 ```
 
 The above example creates a quarter note with a specified size and frames it within a view with a red background.
 */
struct Note: Shape {
    enum StemType {
        case noStem
        case stemUp
        case stemDown
    }

    enum FlagType {
        case noFlag
        case singleFlag
        case doubleFlag
    }
    
    // default attributes
    var noteConfig: NoteConfig

    // explicit attributes
    var noteSize: CGSize
    var noteDuration: NoteDuration = .unknown
    var isDotted: Bool
    
    // inferred attributes
    var isCutout: Bool
    var stemType: StemType
    var flagType: FlagType
    
    /**
     Initializes a new Note with specified size and duration.
    
     Attributes such as `isCutout`, `stemType`, and `flagType` are inferred based on the note's duration.
    
     - Parameters:
       - noteSize: The size of the note head.
       - noteDuration: The duration of the note, which influences its appearance.
    */
    init(noteSize: CGSize, noteDuration: NoteDuration, isDotted: Bool) {
        self.noteConfig = NoteConfig()
        self.noteSize = noteSize
        self.noteDuration = noteDuration
        
        self.isDotted = isDotted
        
        let attributes = Note.attributes(for: noteDuration)
        self.isCutout = attributes.isCutout
        self.stemType = attributes.stemType
        self.flagType = attributes.flagType
    }
    /**
     Generates the path that represents the note.
    
     This method coordinates drawing the note head, stem, and flags based on the note's attributes.
    
     - Parameter rect: The rectangle within which the note is drawn.
     - Returns: A path representing the note.
    */
    func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // Draw Note Head
            drawNoteHead(in: rect, on: &path)
            
            // Draw Stem
            if let stemRect = drawStem(in: rect, on: &path) {
                // Draw Flag if necessary
                drawFlag(in: stemRect, on: &path)
            }
            
            return path
        }
    
    /**
     Draws the note head.
    
     - Parameters:
       - rect: The rectangle within which the note head is drawn.
       - path: The path to which the note head is added.
    */
    private func drawNoteHead(in rect: CGRect, on path: inout Path) {
        let noteHeadRect = CGRect(x: rect.midX, y: rect.maxY, width: noteSize.width, height: noteSize.height)
        let noteHead = NoteHead(isCutout: isCutout)
        path.addPath(noteHead.path(in: noteHeadRect))
        
        if isDotted {
            let dotDiameter: CGFloat = noteSize.width * 0.25
            let dotXPosition = noteHeadRect.maxX
            let dotYPosition = noteHeadRect.midY - noteSize.height - dotDiameter / 2
            let dotRect = CGRect(x: dotXPosition, y: dotYPosition, width: dotDiameter, height: dotDiameter)
           
            path.addEllipse(in: dotRect)
       }
    }
    
    /**
     Draws the stem of the note if applicable.
    
     - Parameters:
       - rect: The rectangle within which the stem is drawn.
       - path: The path to which the stem is added.
     - Returns: A CGRect representing the stem's bounds, if a stem is drawn.
    */
    private func drawStem(in rect: CGRect, on path: inout Path) -> CGRect? {
        let stemWidth = noteSize.width * noteConfig.stemToHeadWidthRatio
        let stemHeight = noteSize.height * noteConfig.stemToHeadHeightRatio
        var stemRect: CGRect? = nil

        switch stemType {
        case .stemUp:
            let stemXPosition = rect.minX + noteSize.width - stemWidth
            stemRect = CGRect(x: stemXPosition, y: rect.minY + noteConfig.stemToHeadYOffset * noteSize.height - stemHeight, width: stemWidth, height: stemHeight)
            path.addRect(stemRect!)
        case .stemDown:
            let stemXPosition = rect.minX
            stemRect = CGRect(x: stemXPosition, y: rect.maxY - noteConfig.stemToHeadYOffset * noteSize.height, width: stemWidth, height: stemHeight)
            path.addRect(stemRect!)
        case .noStem:
            stemRect = nil
        }

        return stemRect
    }
    
    /**
     Draws flags on the note's stem, depending on the note's flag type.
    
     - Parameters:
       - stemRect: The rectangle representing the stem's bounds.
       - path: The path to which the flags are added.
    */
    private func drawFlag(in stemRect: CGRect, on path: inout Path) {
        switch flagType {
        case .singleFlag, .doubleFlag:
            let flagHeight = stemRect.height * noteConfig.flagToStemHeightRatio
            let flagWidth = noteSize.width * noteConfig.flagToHeadWidthRatio
            var flagRect = CGRect.zero
            
            let flagCount = flagType == .singleFlag ? 1 : 2
            for i in 0..<flagCount {
                let flag = NoteFlag()
                
                if stemType == .stemUp {
                    let yOffset = CGFloat(i) * flagHeight * 0.5
                    flagRect = CGRect(x: stemRect.maxX, y: stemRect.minY + yOffset, width: flagWidth, height: flagHeight)
                    path.addPath(flag.path(in: flagRect))
                } else {
                    let yOffset = (1 - CGFloat(i)) * flagHeight * 0.5
                    flagRect = CGRect(x: stemRect.maxX, y: stemRect.maxY - yOffset, width: flagWidth, height: flagHeight)
                    
                    let mirrorTransform = CGAffineTransform(scaleX: 1.0, y: -1.0).translatedBy(x: 0, y: -3.3 * flagRect.height)
                    
                    let mirroredPath = flag.path(in: flagRect).applying(mirrorTransform)
                    
                    path.addPath(mirroredPath)
                }
                
            }
        case .noFlag:
            break
        }
    }
    
    /**
     Determines the attributes of a note based on its duration.
    
     This static method provides a convenient way to determine whether a note should have a cutout, the type of stem, and the number of flags based on its musical duration.
    
     - Parameter duration: The musical duration of the note.
     - Returns: A tuple containing the isCutout flag, stem type, and flag type.
    */
    static func attributes(for duration: NoteDuration) -> (isCutout: Bool, stemType: StemType, flagType: FlagType) {
        switch duration {
        case .full:
            return (true, .noStem, .noFlag)
        case .half:
            return (true, .stemUp, .noFlag)
        case .quarter:
            return (false, .stemUp, .noFlag)
        case .eighth:
            return (false, .stemUp, .singleFlag)
        case .sixteenth:
            return (false, .stemUp, .doubleFlag)
        case .unknown:
            return (false, .noStem, .noFlag)
        }
    }
}

#Preview {
    Note(noteSize: CGSize(20, 20), noteDuration: .sixteenth, isDotted: true)
        .frame(width: 20, height: 20)
}
