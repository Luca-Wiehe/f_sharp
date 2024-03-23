import SwiftUI

enum PatternEditingStage {
    case restOrNote
    case duration
    case pitch
}

enum DurationType {
    case note
    case rest
}

struct EditPatternView: View {
    var onSave: () -> Void
    var onCancel: () -> Void
    
    @State private var stage = PatternEditingStage.restOrNote
    @State private var selectedDurationType: DurationType = .note
    @State private var selectedDuration: NoteDuration = .unknown
    @State private var isDottedSelection: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button("Cancel") {
                        onCancel()
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        onSave()
                    }
                }
                .padding(.top, 32)
                
                Spacer()
                
                Text("Rendered Pattern")
                
                Spacer()
                
                Group {
                    if stage == .restOrNote {
                        RestOrNoteView(stage: $stage, selectedDurationType: $selectedDurationType)
                    } else if stage == .duration {
                        DurationView(stage: $stage, selectedDurationType: $selectedDurationType, isDottedSelection: $isDottedSelection)
                    } else {
                        PitchView(stage: $stage)
                    }
                }
                .frame(width: geometry.size.width - 64, height: geometry.size.height * 0.33)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
            }
            .padding(.horizontal, 32)
        }
    }
}
