import SwiftUI

struct PitchView: View {
    @Binding var stage: PatternEditingStage
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                DialogHeader(title: "Choose Pitch").padding(.bottom)
                
                GeometryReader { geometry in
                    let totalHorizontalSpacing: CGFloat = 4 * 8 // For 5 columns, adjusting spacing
                    let availableWidth: CGFloat = geometry.size.width - totalHorizontalSpacing
                    let buttonWidth: CGFloat = availableWidth / 5 // Width for each button
                    
                    let totalVerticalSpace: CGFloat = geometry.size.height - (geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom)
                    let buttonHeight: CGFloat = totalVerticalSpace / 4 // Height for each button
                    
                    VStack(spacing: 8) {
                        ForEach(0..<2, id: \.self) { _ in // Only need to iterate for the number of vertical button groups, not rows
                            HStack(spacing: 8) {
                                ForEach(0..<4, id: \.self) { _ in // Create buttons for the first four columns
                                    Button(action: {
                                        self.stage = .restOrNote
                                    }) {
                                        ZStack {
                                            StaffLinesView(lineSpacing: 8, lineHeight: 1)
                                            NoteSymbol(noteSize: CGSize(width: 8, height: 8), noteDuration: .quarter, isDotted: false)
                                                .frame(width: 8, height: 8)
                                        }
                                    }
                                    .frame(width: buttonWidth, height: buttonHeight * 2 + 8) // Button spans two rows
                                    .cornerRadius(20)
                                    .gradientModifier(gradientColors: [Color.blue, Color.teal], options: [.stroke, .contentAndText], strokeWidth: 2)
                                }
                                
                                // Spacer() might not be necessary unless specific alignment is required
                                
                                // Creating the button for the last column
                                // This loop is incorrect based on your error message; however, you'd handle the last column separately.
                            }
                        }
                        // Handling the last column with buttons fitting into one row each
                        VStack(spacing: 8) {
                            ForEach(0..<4, id: \.self) { _ in
                                Button(action: {}) {
                                    Image(systemName: "music.note")
                                }
                                .frame(width: buttonWidth, height: buttonHeight)
                                .cornerRadius(10)
                                .gradientModifier(gradientColors: [Color.pink, Color.purple], options: [.stroke, .contentAndText], strokeWidth: 1)
                            }
                        }
                    }
                    .frame(width: geometry.size.width, height: totalVerticalSpace)
                }
                
                Spacer()
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
