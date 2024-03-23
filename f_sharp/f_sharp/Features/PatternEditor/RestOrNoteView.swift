import SwiftUI

struct RestOrNoteView: View {
    @Binding var stage: PatternEditingStage
    @Binding var selectedDurationType: DurationType

    var body: some View {
        VStack(spacing: 20) {
            DialogHeader(title: "Add Note or Rest?")

            HStack(spacing: 32) {
                SubtitledButton(text: "Rest", gradientColors: [Color.pink, Color.purple], onAction: {
                    print("Rest clicked")
                    stage = .duration
                    selectedDurationType = .rest
                }){
                    ZStack {
                        StaffLinesView(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        QuarterRest()
                            .frame(width: 20, height: 45)
                    }
                }
                
                SubtitledButton(text: "Note", gradientColors: [Color.blue, Color.teal], onAction: {
                    print("Note clicked")
                    stage = .duration
                    selectedDurationType = .note
                }){
                    ZStack {
                        StaffLinesView(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        
                        NoteSymbol(noteSize: CGSize(width: 15, height: 15), noteDuration: .quarter, isDotted: false)
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
