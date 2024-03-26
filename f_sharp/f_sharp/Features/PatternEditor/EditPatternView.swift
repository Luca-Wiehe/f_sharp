import SwiftUI

enum PatternEditingStage {
    case restOrNote
    case duration
    case pitch
}

enum NoteType {
    case note
    case rest
}

struct EditPatternView: View {
    var onSave: () -> Void
    var onCancel: () -> Void
    
    @State private var stage = PatternEditingStage.restOrNote
    @State private var selectedNoteType: NoteType = .note
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
                
                DeleteLastNoteButton(onDelete: {
                    print("Delete last note")
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 32)
                
                Group {
                    if stage == .restOrNote {
                        RestOrNoteView(stage: $stage, selectedNoteType: $selectedNoteType)
                    } else if stage == .duration {
                        DurationView(stage: $stage, selectedDuration: $selectedDuration, selectedNoteType: $selectedNoteType, isDottedSelection: $isDottedSelection)
                    } else {
                        PitchView(stage: $stage, selectedDuration: $selectedDuration, isDottedSelection: $isDottedSelection)
                    }
                }
                .frame(width: geometry.size.width - 64, height: geometry.size.height * 0.33)
                .background(Color(UIColor.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
    }
}

struct DeleteLastNoteButton: View {
    var onDelete: () -> Void
    
    var body: some View {
        Button(action: onDelete) {
            HStack {
                Image(systemName: "delete.left")
                    .foregroundColor(.black) // Set icon color to black
            }
            .padding()
            .background(Color.white) // Set button background to white
            .cornerRadius(20)
            .shadow(radius: 5) // Add shadow
        }
    }
}
