import SwiftUI

struct PitchView: View {
    @Binding var stage: PatternEditingStage
    
    var body: some View {
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
            
            BackButton(action: {
                stage = .duration
            })
                .padding(.top, 16)
                .padding(.leading, 16)
        }
    }
}
