import Foundation

/**
A base class for different types of musical symbols.
*/
class MusicSymbol {
    var description: String {
        return "MusicSymbol"
    }
}

/**
An enum representing the types of clefs.
*/
enum ClefType {
    case treble, bass, violin, percussion, unknown
}

/**
An enum representing the types of bar lines.
*/
enum BarlineType {
    case single, double, endRepeat, startRepeat, boldDouble
}

/**
An enum representing the durations of notes.
*/
enum NoteDuration {
    case sixteenth, eighth, quarter, half, full, unknown
}

/**
A class representing a clef, which indicates the pitch of written notes.
*/
class Clef: MusicSymbol {
    var clefType: ClefType
    var keySignature: String
    
    /**
    Initializes a new Clef with a specified type and key signature.
    
    - Parameters:
      - clefType: The type of the clef (e.g., Treble or Bass).
      - keySignature: The key signature associated with the clef.
    */
    init(clefType: ClefType, keySignature: String) {
        self.clefType = clefType
        self.keySignature = keySignature
        super.init()
    }
    
    override var description: String {
        return """
        Clef
         - clefType: \(clefType)
         - keySignature: \(keySignature)
        """
    }
}

/**
A class representing a time signature, which defines the number of beats in each measure and the note value that represents one beat.
*/
class Time: MusicSymbol {
    var beats: Int
    var beatType: Int
    
    /**
    Initializes a new Time signature.
    
    - Parameters:
      - beats: The number of beats per measure.
      - beatType: The note value that represents one beat.
    */
    init(beats: Int, beatType: Int) {
        self.beats = beats
        self.beatType = beatType
        super.init()
    }
    
    override var description: String {
        return """
        Time
         - beats: \(beats)
         - beatType: \(beatType)
        """
    }
}

/**
A class representing a musical note, which has a duration and optionally a tone.
*/
class MusicNote: MusicSymbol {
    var duration: NoteDuration
    var tone: String?
    var isDotted: Bool
    
    /**
    Initializes a new musical note.
    
    - Parameters:
      - duration: The duration of the note (e.g., quarter, half).
      - tone: The tone of the note, optional for rests.
      - isDotted: A boolean indicating whether the note's duration is extended by 50%.
    */
    init(duration: NoteDuration, tone: String? = nil, isDotted: Bool = false) {
        self.duration = duration
        self.tone = tone
        self.isDotted = isDotted
        super.init()
    }
    
    override var description: String {
        return """
        MusicNote
         - duration: \(duration)
         - tone: \(tone ?? "nil")
         - isDotted: \(isDotted)
        """
    }
}

/**
A class representing a rest, a period of silence in a piece of music.
*/
class Rest: MusicNote {
    
    /**
    Initializes a new rest with a specified duration.
    
    - Parameter duration: The duration of the rest.
    */
    init(duration: NoteDuration) {
        super.init(duration: duration, tone: nil)
    }
    
    override var description: String {
        return """
        Rest
         - duration: \(duration)
        """
    }
}

/**
A class representing a barline, which divides music into measures.
*/
class Barline: MusicSymbol {
    var barlineType: BarlineType
    
    /**
    Initializes a new barline with a specified type.
    
    - Parameter barlineType: The type of the barline.
    */
    init(barlineType: BarlineType) {
        self.barlineType = barlineType
        super.init()
    }
    
    override var description: String {
        return """
        Barline
         - barlineType: \(barlineType)
        """
    }
}
