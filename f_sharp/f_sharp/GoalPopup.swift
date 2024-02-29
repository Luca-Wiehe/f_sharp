import SwiftUI

struct GoalPopup: View {
    @State private var titleOfGoal: String = ""
    @State private var timeHorizon: String = "Weekly"
    @State private var goalMeasure: String = "# Practice Sessions"
    @State private var numberOfSessions: String = ""
    @State private var practiceHours: String = ""
    @State private var practiceMinutes: String = ""
    @State private var numberOfPatterns: String = ""

    let timeHorizonOptions = ["Daily", "Weekly", "Monthly", "Never"]
    let goalMeasureOptions = ["# Practice Sessions", "Practice Time", "# Patterns"]

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Goal", text: $titleOfGoal)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    .font(.system(.largeTitle, design: .default).weight(.bold))

                Text("Repeat")
                    .font(.title).bold()
                    .padding(.bottom, 5)
                
                customPicker(options: timeHorizonOptions, selection: $timeHorizon)
                
                Text("Measurement")
                    .font(.title).bold()
                    .padding(.vertical, 5)
                
                customPicker(options: goalMeasureOptions, selection: $goalMeasure)
                
                if goalMeasure == "# Practice Sessions" {
                    TextField("Number of Sessions", text: $numberOfSessions)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .font(.system(size: 24, weight: .bold))
                } else if goalMeasure == "Practice Time" {
                    HStack {
                        TextField("Hours", text: $practiceHours)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                            .font(.system(size: 24, weight: .bold))
                            .onReceive(practiceHours.publisher.collect()) {
                                practiceHours = String($0.prefix(2)).filter { "0123456789".contains($0) }
                            }
                        
                        TextField("Minutes", text: $practiceMinutes)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                            .font(.system(size: 24, weight: .bold))
                            .onReceive(practiceMinutes.publisher.collect()) {
                                practiceMinutes = String($0.prefix(2)).filter { "0123456789".contains($0) }
                                if let intValue = Int(practiceMinutes), intValue > 59 {
                                    practiceMinutes = "59"
                                }
                            }
                    }
                } else if goalMeasure == "# Patterns" {
                    TextField("Number of Patterns", text: $numberOfPatterns)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        .font(.system(size: 24, weight: .bold))
                }
            }
            .padding()
            
            Button(action: {
                print("Goal added") // Placeholder action
            }) {
                Text("Add Goal")
                    .font(.system(size: 18, weight: .bold))
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
    }
    
    func backgroundForOption(_ option: String, selectedOption: String) -> some View {
        LinearGradient(gradient: Gradient(colors: option == selectedOption ? [Color.blue, Color.purple] : [Color.gray.opacity(0.3), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)
    }
    
    private func calculateHeightMultiplier(for options: [String]) -> Int {
        let longestOptionLength = options.map { $0.count }.max() ?? 0
        return max(1, (longestOptionLength / 10) + 1)
    }
}
