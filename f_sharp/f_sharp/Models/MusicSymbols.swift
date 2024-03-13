// Base class for type specifications
class MusicSymbol {
}

class Clef: MusicSymbol {
    // 0: TrebleClef, 1: BassClef
    var clefType: Int
    var keySignature: String
    
    init(clefType: Int, keySignature: String) {
        self.clefType = clefType
        self.keySignature = keySignature
        super.init()
    }
}

class Time: MusicSymbol {
    var beats: Int
    var beatType: Int
    
    init(beats: Int, beatType: Int) {
        self.beats = beats
        self.beatType = beatType
        super.init()
    }
}

class MusicNote: MusicSymbol {
    var duration: Int
    var tone: String?
    
    init(duration: Int, tone: String? = nil) {
        self.duration = duration
        self.tone = tone
        super.init()
    }
}

class Rest: MusicNote {
    override init(duration: Int, tone: String? = nil) {
        super.init(duration: duration, tone: tone)
    }
}

class Barline: MusicSymbol {
    var barlineType: Int
    
    init(barlineType: Int) {
        self.barlineType = barlineType
        super.init()
    }
}
