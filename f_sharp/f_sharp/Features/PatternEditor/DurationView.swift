import SwiftUI

struct DurationView: View {
    @Binding var stage: PatternEditingStage
    @Binding var selectedDurationType: DurationType
    @Binding var isDottedSelection: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 20) {
                DialogHeader(title: "Choose Duration")
                
                HStack(spacing: 10) {
                    ForEach(NoteDuration.displayableCases, id: \.self) { duration in
                        Button(action: {
                            switch selectedDurationType {
                            case .note:
                                stage = .pitch
                            case .rest:
                                stage = .restOrNote
                            }
                            self.stage = .pitch
                        }) {
                            VStack{
                                ZStack {
                                    StaffLinesView(lineSpacing: 15, lineHeight: 2)
                                        .frame(width: 50, height: 70)
                                    switch selectedDurationType {
                                    case .note:
                                        if duration == .sixteenth || duration == .full {
                                            NoteSymbol(noteSize: CGSize(width: 15, height: 15), noteDuration: duration, isDotted: false)
                                                .frame(width: 15, height: 15)
                                                .offset(x: 0, y: 8)
                                        }
                                        else {
                                            NoteSymbol(noteSize: CGSize(width: 15, height: 15), noteDuration: duration, isDotted: isDottedSelection)
                                                .frame(width: 15, height: 15)
                                                .offset(x: 0, y: 8)
                                        }
                                    case .rest:
                                        RestSymbol(lineSpacing: 15, restDuration: duration, isDotted: isDottedSelection)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .cornerRadius(20)
                            .gradientModifier(gradientColors: [Color.blue, Color.teal], options: [.contentAndText, .stroke], strokeWidth: 2)
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                HStack {
                    Button(action: {
                        self.isDottedSelection = !isDottedSelection
                    }) {
                        VStack {
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                        .frame(width: 80, height: 80)
                        .gradientModifier(
                            gradientColors: [Color.pink, Color.purple],
                            options: isDottedSelection ? [.background] : [.stroke, .contentAndText],
                            strokeWidth: 2
                        )
                        .padding(.vertical, 16)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            BackButton(action: {
                stage = .restOrNote
            })
                .padding(.top, 16)
                .padding(.leading, 16)
        }
    }
}
