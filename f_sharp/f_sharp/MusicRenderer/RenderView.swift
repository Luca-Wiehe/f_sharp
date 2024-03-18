import SwiftUI

struct RenderView: View {
    let lineHeight: CGFloat
    let lineSpacing: CGFloat
    
    let parser: MusicXMLParser
    let musicSymbols: [MusicSymbol]
    
    @State private var currentXOffset: CGFloat = 0
    
    init(lineHeight: CGFloat, lineSpacing: CGFloat, pattern: String) {
        self.lineHeight = lineHeight
        self.lineSpacing = lineSpacing
        
        // initialize parser and parse content of MusicXML
        self.parser = MusicXMLParser()
        self.musicSymbols = parser.parseMusicXML(pattern)
        
        for musicSymbol in self.musicSymbols {
            print(musicSymbol.description)
        }
    }
    
    var body: some View {
        ZStack (alignment: .leading) {
            StaffLines(lineSpacing: lineSpacing, lineHeight: lineHeight)
            
            ForEach(0..<musicSymbols.count, id: \.self) {
                index in
                symbolView(for: musicSymbols[index])
                    .offset(x: self.offset(for: index), y: 0)
            }
        }
    }
    
    @ViewBuilder
    private func symbolView(for symbol: MusicSymbol) -> some View {
        if let time = symbol as? Time {
            TimeSignature(beatsPerMeasure: time.beats, beatType: time.beatType)
                .frame(width: 3 * lineSpacing, height: 4 * lineSpacing)
        } else if let clef = symbol as? Clef, clef.clefType == .treble {
            TrebleClef()
                .frame(width: 2.5 * lineSpacing, height: 6 * (lineSpacing + lineHeight))
        } else if let clef = symbol as? Clef, clef.clefType == .bass {
            BassClef()
                .frame(width: 2.5 * lineSpacing, height: 3
                       * (lineSpacing + lineHeight))
        } else if symbol is Rest {
            Rectangle().frame(width: lineSpacing * 1.5, height: lineSpacing / 2)
        } else if symbol is MusicNote {
            // Note()
        }
    }
    
    private func offset(for index: Int) -> CGFloat {
        CGFloat(index) * lineSpacing * 3.5
    }
}

#Preview {
    RenderView(lineHeight: 1, lineSpacing: 20, pattern: """
        <part id="P1">
            <measure number="1">
              <attributes>
                <divisions>24</divisions>
                <time>
                  <beats>3</beats>
                  <beat-type>4</beat-type>
                </time>
                <clef>
                  <sign>F</sign>
                  <line>2</line>
                </clef>
              </attributes>
              <note>
                <rest/>
                <duration>72</duration>
                <voice>1</voice>
              </note>
            </measure>
        </part>
    """)
}
      
