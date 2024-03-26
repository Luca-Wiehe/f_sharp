import SwiftUI

struct RestOrNoteView: View {
    @Binding var stage: PatternEditingStage
    @Binding var selectedNoteType: NoteType

    var body: some View {
        VStack(spacing: 20) {
            DialogHeader(title: "Add Note or Rest?")

            HStack(spacing: 32) {
                SubtitledButton(text: "Rest", gradientColors: [Color.pink, Color.purple], onAction: {
                    stage = .duration
                    selectedNoteType = .rest
                }){
                    ZStack {
                        StaffLinesView(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        QuarterRest()
                            .frame(width: 20, height: 45)
                    }
                }
                
                SubtitledButton(text: "Note", gradientColors: [Color.blue, Color.teal], onAction: {
                    stage = .duration
                    selectedNoteType = .note
                }){
                    ZStack {
                        StaffLinesView(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        
                        NoteSymbol(noteSize: CGSize(width: 15, height: 15), noteDuration: .quarter, isDotted: false, stemType: .stemUp)
                            .frame(width: 15, height: 45)
                            .offset(y: 30)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .padding()
    }
}
