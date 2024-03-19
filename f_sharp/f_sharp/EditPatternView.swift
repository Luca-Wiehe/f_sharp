import SwiftUI

enum PatternEditingStage {
    case restOrNote
    case duration
    case pitch
}

struct EditPatternView: View {
    var onSave: () -> Void
    var onCancel: () -> Void
    
    @State private var stage = PatternEditingStage.restOrNote
    
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
                        restOrNoteView
                    } else if stage == .duration {
                        durationView
                    } else {
                        pitchView
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
    
    var restOrNoteView: some View {
        VStack(spacing: 20) {
            Text("Add Note or Rest?")
                .font(.system(size: 36, weight: .heavy))
                .foregroundColor(.black)
            
            HStack(spacing: 20) {
                GradientButton(text: "Rest", gradientColors: [Color.pink, Color.purple], onAction: {
                    stage = .duration
                }){
                    StaffLines(lineSpacing: 15, lineHeight: 2)
                }
                GradientButton(text: "Note", gradientColors: [Color.blue, Color.teal], onAction: {
                    stage = .duration
                }){
                    
                }
            }
        }
        .padding()
    }
    
    var durationView: some View {
        VStack {
            ForEach(0..<2, id: \.self) { _ in
                HStack {
                    ForEach(0..<4, id: \.self) { _ in
                        Button("Option") { stage = .pitch }
                    }
                }
            }
            backButton(previousStage: .restOrNote)
        }
    }
    
    var pitchView: some View {
        VStack {
            ForEach(0..<2, id: \.self) { _ in
                HStack {
                    ForEach(0..<7, id: \.self) { _ in
                        Button("Final Option") { }
                    }
                }
            }
            backButton(previousStage: .duration)
        }
    }
    
    func backButton(previousStage: PatternEditingStage) -> some View {
        Button(action: {
            self.stage = previousStage
        }) {
            Text("Back")
                .foregroundColor(.blue)
                .padding()
                .border(Color.blue, width: 2)
        }
    }
    
    struct GradientButton<Content: View>: View {
        let text: String
        let gradientColors: [Color]
        let onAction: () -> Void
        @ViewBuilder var content: () -> Content?
        
        var body: some View {
            Button(action: {
                onAction()
            }) {
                ZStack {
                    VStack {
                        Spacer()
                        
                        if let contentView = content() {
                            contentView.overlay(
                                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)
                                    .mask(contentView)
                            )
                        }
                        
                        Text(text)
                            .font(.system(size: 28, weight: .heavy))
                            .frame(width: UIScreen.main.bounds.width / 4)
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                            .mask(Text(text)
                                .font(.system(size: 28, weight: .heavy))
                            )
                        
                        Spacer()
                    }
                    .background(Color.yellow)
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.clear))
            }
        }
    }
}
