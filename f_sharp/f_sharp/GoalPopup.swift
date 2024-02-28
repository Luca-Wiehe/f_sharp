import SwiftUI

struct GoalPopup: View {
    @State private var titleOfGoal: String = ""
    @State private var timeHorizon: String = "Weekly"
    @State private var goalMeasure: String = "# Practice Sessions"
    
    let timeHorizonOptions = ["Weekly", "Monthly"]
    let goalMeasureOptions = ["# Practice Sessions", "Practice Time", "# Patterns"]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("What is your goal?", text: $titleOfGoal)
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .font(.system(.largeTitle, design: .default).weight(.bold))

                    Text("How frequently should your goal repeat?")
                        .font(.title).bold()
                        .padding(.bottom, 5)
                    
                    customPicker(options: timeHorizonOptions, selection: $timeHorizon)
                    
                    Text("Specify your goal details")
                        .font(.title).bold()
                        .padding(.vertical, 5)
                    
                    customPicker(options: goalMeasureOptions, selection: $goalMeasure)
                }
                .padding()
            }
            
            Spacer() // Pushes the button to the bottom when ScrollView is not full
            
            Button(action: {
                // Implement your action here
                print("Goal added") // Placeholder action
            }) {
                Text("Add Goal")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }

    func customPicker(options: [String], selection: Binding<String>) -> some View {
        let heightMultiplier = calculateHeightMultiplier(for: options)
        return HStack {
            ForEach(options, id: \.self) { option in
                Text(option)
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, minHeight: 44 * CGFloat(heightMultiplier), alignment: .center)
                    .background(self.backgroundForOption(option, selectedOption: selection.wrappedValue))
                    .cornerRadius(10)
                    .foregroundColor(option == selection.wrappedValue ? .white : .primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 18, weight: .bold))
                    .onTapGesture {
                        selection.wrappedValue = option
                    }
            }
        }
        .padding(.horizontal, -10)
    }
    
    func backgroundForOption(_ option: String, selectedOption: String) -> some View {
        LinearGradient(gradient: Gradient(colors: option == selectedOption ? [Color.blue, Color.purple] : [Color.gray.opacity(0.3), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)
    }
    
    private func calculateHeightMultiplier(for options: [String]) -> Int {
        let longestOptionLength = options.map { $0.count }.max() ?? 0
        return max(1, (longestOptionLength / 10) + 1)
    }
}
