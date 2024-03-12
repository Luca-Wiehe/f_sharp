import Foundation

class Clef {
    // 0: TrebleClef, 1: BassClef
    var clefType: Int
    var keySignature: String
    
    init(clefType: Int, keySignature: String) {
        self.clefType = clefType
        self.keySignature = keySignature
    }
}

class Time {
    var beats: Int
    var beatType: Int
    
    init(beats: Int, beatType: Int) {
        self.beats = beats
        self.beatType = beatType
    }
}

class MusicNote {
    var duration: Int
    var tone: String?
    
    init(duration: Int, tone: String? = nil) {
        self.duration = duration
        self.tone = tone
    }
}

class Rest: MusicNote {
}


class Barline {
    var barlineType: Int
    
    init(barlineType: Int) {
        self.barlineType = barlineType
    }
}
