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
            DialogHeader(title: "Add Note or Rest?")

            HStack(spacing: 32) {
                GradientButton(text: "Rest", gradientColors: [Color.pink, Color.purple], onAction: {
                    stage = .duration
                    selectedDurationType = .rest
                }){
                    ZStack {
                        StaffLines(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        QuarterRest()
                            .frame(width: 20, height: 45)
                    }
                }
                GradientButton(text: "Note", gradientColors: [Color.blue, Color.teal], onAction: {
                    stage = .duration
                    selectedDurationType = .note
                }){
                    ZStack {
                        StaffLines(lineSpacing: 15, lineHeight: 2)
                            .frame(width: 50)
                        Note(noteSize: CGSize(width: 15, height: 15), noteDuration: .quarter, isDotted: false)
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

    
    var durationView: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 20) {
                DialogHeader(title: "Choose Duration")
                
                HStack(spacing: 10) {
                    ForEach(NoteDuration.displayableCases, id: \.self) { duration in
                        Button(action: {
                            self.stage = .pitch
                        }) {
                            VStack{
                                StaffLines(lineSpacing: 15, lineHeight: 2)
                                    .frame(width: 50, height: 70)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .cornerRadius(20)
                            .gradientContentAndStroke(gradientColors: [Color.blue, Color.teal])
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                if selectedDurationType == .note {
                    HStack {
                        Button(action: {
                            self.isDottedSelection = !isDottedSelection
                        }) {
                            Text("Dotted")
                                .frame(width: 80)
                                .fontWeight(.heavy)
                                .padding()
                                .padding(.vertical, 16)
                                .cornerRadius(20)
                                .gradientBackgroundOrContent(gradientColors: [Color.pink, Color.purple], isSelected: isDottedSelection)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            backButton(previousStage: .restOrNote)
                .padding(.top, 16)
                .padding(.leading, 16)
        }
    }
    
    var pitchView: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                DialogHeader(title: "Choose Pitch")
                
                ForEach(0..<2, id: \.self) { _ in
                    HStack {
                        ForEach(0..<7, id: \.self) { _ in
                            Button("Final Option") { }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            backButton(previousStage: .duration)
                .padding(.top, 16)
                .padding(.leading, 16)
        }
        
    }
    
    func backButton(previousStage: PatternEditingStage) -> some View {
        Button(action: {
            self.stage = previousStage
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.blue)
        }
    }
    
    struct DialogHeader: View {
        var title: String
        
        var body: some View {
            Text(title)
                .font(.system(size: 36, weight: .heavy))
                .foregroundColor(.black)
                .padding(.top, 32)
                .padding(.bottom, 16)
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
                            .frame(width: UIScreen.main.bounds.width / 4 - 32)
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                            .mask(Text(text)
                                .font(.system(size: 28, weight: .heavy))
                            )
                        
                        Spacer()
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing), lineWidth: 3))
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.clear))
            }
        }
    }
}

struct GradientBackgroundButtonModifier: ViewModifier {
    var isSelected: Bool
    var gradientColors: [Color]
    
    func body(content: Content) -> some View {
        if isSelected {
            content
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
        } else {
            content
                .gradientContentAndStroke(gradientColors: gradientColors)
        }
    }
}

extension View {
    func gradientBackgroundOrContent(gradientColors: [Color], isSelected: Bool) -> some View {
        self.modifier(GradientBackgroundButtonModifier(isSelected: isSelected, gradientColors: gradientColors))
    }
}

struct GradientContentButtonModifier: ViewModifier {
    var gradientColors: [Color]
    var lineWidth: CGFloat = 3
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)
                    .mask(content)
            )
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(LinearGradient(gradient: Gradient(colors: gradientColors),
                                               startPoint: .leading,
                                               endPoint: .trailing),
                                lineWidth: lineWidth))
    }
}

extension View {
    func gradientContentAndStroke(gradientColors: [Color], lineWidth: CGFloat = 3) -> some View {
        self.modifier(GradientContentButtonModifier(gradientColors: gradientColors, lineWidth: lineWidth))
    }
}
