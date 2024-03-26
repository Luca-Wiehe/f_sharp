import SwiftUI

struct PitchView: View {
    @Binding var stage: PatternEditingStage
    @Binding var selectedDuration: NoteDuration
    @Binding var isDottedSelection: Bool
    
    @State var isFlat: Bool = false
    @State var isSharp: Bool = false
    @State var octave: Int = 4
    
    let musicNotes = ["C", "D", "E", "F", "G", "A", "B", "C"]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                DialogHeader(title: "Choose Pitch").padding(.bottom)
                
                GeometryReader { geometry in
                    HStack(spacing: 16) {
                        VStack(spacing: 16) {
                            ForEach(0..<2) { i in
                                HStack(spacing: 8) {
                                    ForEach(0..<4) { j in
                                        let index = 4 * i + j
                                        let note = musicNotes[index] + (isSharp ? "♯" : "") + (isFlat ? "♭" : "")
                                        let offset = calculateNoteOffset(for: index, octave: octave)
                                        Group1Button(
                                            subtitle: note,
                                            noteOffset: offset,
                                            duration: selectedDuration,
                                            isDottedSelection: isDottedSelection,
                                            action: {
                                                stage = .restOrNote
                                            },
                                            isDisabled: (index < 6 && octave == 3) || (index > 3 && octave == 6)
                                        )
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                        VStack(spacing: 8) {
                            Group2Button(
                                action: {
                                    isFlat.toggle()
                                    isSharp = false
                                },
                                isSelected: isFlat,
                                isDisabled: false,
                                iconName: "♭"
                            )
                            .frame(height: (geometry.size.height - (4 * 8)) / 4)
                            
                            Group2Button(
                                action: {
                                    isSharp.toggle()
                                    isFlat = false
                                },
                                isSelected: isSharp,
                                isDisabled: false,
                                iconName: "♯"
                            )
                            .frame(height: (geometry.size.height - (4 * 8)) / 4)
                            .padding(.bottom, 8)
                            
                            Group2Button(
                                action: {
                                    octave += 1
                                },
                                isSelected: false,
                                isDisabled: octave == 6,
                                iconName: "↑"
                            )
                            .frame(height: (geometry.size.height - (4 * 8)) / 4)
                            
                            Group2Button(
                                action: {
                                    octave -= 1
                                },
                                isSelected: false,
                                isDisabled: octave == 3,
                                iconName: "↓")
                            .frame(height: (geometry.size.height - (4 * 8)) / 4)
                        }
                        
                        .frame(width: geometry.size.width * 0.1)
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
    
    private func calculateNoteOffset(for index: Int, octave: Int) -> CGFloat {
        let referenceIndex = musicNotes.firstIndex(of: "B") ?? 7
        let stepsFromReference = index - referenceIndex
        let octaveAdjustment = (4 - octave) * 28
        return CGFloat(stepsFromReference * -4 + octaveAdjustment)
    }
}


struct Group1Button: View {
    let subtitle: String
    let noteOffset: CGFloat
    let duration: NoteDuration
    let isDottedSelection: Bool
    let action: () -> Void
    let isDisabled: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            if isDisabled {
                Image(systemName: "nosign")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                Text("Invalid")
                    .bold()
            } else {
                ZStack {
                    StaffLinesView(lineSpacing: 8, lineHeight: 1)
                    
                    ForEach(calculateSupportingLinesOffsets(), id: \.self) { offset in
                        Rectangle()
                            .frame(width: 12, height: 1)
                            .offset(x: 0, y: offset)
                    }
                    
                    NoteSymbol(noteSize: CGSize(width: 8, height: 8), noteDuration: duration, isDotted: isDottedSelection, stemType: noteOffset > 0 ? .stemUp : .stemDown)
                        .frame(width: 8, height: 8)
                        .offset(x: 0, y: noteOffset)
                }
                Text(subtitle)
                    .bold()
            }
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(20)
        .gradientModifier(gradientColors: isDisabled ? [Color.gray, Color.gray.opacity(0.7)] : [Color.blue, Color.teal], options: [.stroke, .contentAndText], strokeWidth: 2)
        .onTapGesture {
            if !isDisabled {
                action()
            }
        }
    }
    
    private func calculateSupportingLinesOffsets() -> [CGFloat] {
        var offsets: [CGFloat] = []
        let stepSize: CGFloat = 8
        if noteOffset >= 24 {
            var currentOffset = 24.0
            while currentOffset <= noteOffset {
                offsets.append(currentOffset)
                currentOffset += stepSize
            }
        } else if noteOffset <= -24 {
            var currentOffset = -24.0
            while currentOffset >= noteOffset {
                offsets.append(currentOffset)
                currentOffset -= stepSize
            }
        }
        return offsets
    }
}


struct Group2Button: View {
    let action: () -> Void
    let isSelected: Bool
    let isDisabled: Bool
    let iconName: String
    
    var body: some View {
        Text(iconName)
            .font(.title)
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gradientModifier(gradientColors: isDisabled ? [Color.gray, Color.gray.opacity(0.7)] : [Color.pink, Color.purple], options: isSelected ? [.background] : [.stroke, .contentAndText], strokeWidth: 2)
        .onTapGesture {
            if !isDisabled {
                action()
            }
        }
    }
}

