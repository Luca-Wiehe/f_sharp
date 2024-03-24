import SwiftUI

struct PitchView: View {
    @Binding var stage: PatternEditingStage
    
    var body: some View {
            ZStack(alignment: .topLeading) {
                VStack {
                    DialogHeader(title: "Choose Pitch").padding(.bottom)
                    
                    GeometryReader { geometry in
                        HStack(spacing: 8) {
                            VStack(spacing: 8) {
                                ForEach(0..<2) { i in
                                    HStack(spacing: 8) {
                                        ForEach(0..<4) { j in
                                            Group1Button(subtitle: "\(i * 4 + j)")
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            Spacer()
                            
                            VStack(spacing: 8) {
                                ForEach(0..<4) { _ in
                                    Group2Button()
                                        .frame(height: (geometry.size.height - (3 * 8)) / 4) // Adjust the height dynamically
                                }
                            }
                            .frame(width: geometry.size.width * 0.2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                BackButton(action: {
                    stage = .duration
                })
                .padding(.top, 16)
                .padding(.leading, 16)
            }
    }
}


struct Group1Button: View {
    let subtitle: String
    
    var body: some View {
        
        Button(action: {
            
        }) {
            VStack {
                Spacer()
                ZStack {
                    StaffLinesView(lineSpacing: 8, lineHeight: 1)
                    NoteSymbol(noteSize: CGSize(width: 8, height: 8), noteDuration: .quarter, isDotted: false)
                        .frame(width: 8, height: 8)
                }
                Text(subtitle)
                    .bold()
                Spacer()
            }
        }
        .cornerRadius(20)
        .gradientModifier(gradientColors: [Color.blue, Color.teal], options: [.stroke, .contentAndText], strokeWidth: 2)
    }
}

struct Group2Button: View {
    var body: some View {
        Button(action: {
            
        }) {
            Image(systemName: "music.note")
        }
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gradientModifier(gradientColors: [Color.pink, Color.purple], options: [.stroke, .contentAndText], strokeWidth: 2)
    }
}
