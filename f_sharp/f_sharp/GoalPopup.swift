import SwiftUI

// GoalMeasure is an enumeration to avoid magic strings and make the handling of different goal measures more robust.
enum GoalMeasure: String, CaseIterable {
    case practiceSessions = "# Practice Sessions"
    case practiceTime = "Practice Time"
    case patterns = "# Patterns"
    
    var displayName: String {
        self.rawValue
    }
}

// CustomTextFieldStyle for common TextField styling
struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.primary.opacity(0.1))
            .foregroundColor(.primary)
            .cornerRadius(10)
            .font(.system(size: 24, weight: .bold))
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}

// GoalPopup view with improvements
struct GoalPopup: View {
    @State private var titleOfGoal: String = ""
    @State private var timeHorizon: String = "Weekly"
    @State private var goalMeasure: GoalMeasure = .practiceSessions
    @State private var numberOfSessions: String = ""
    @State private var practiceHours: String = ""
    @State private var practiceMinutes: String = ""
    @State private var numberOfPatterns: String = ""

    let timeHorizonOptions = ["Daily", "Weekly", "Monthly", "Never"]
    
    var body: some View {
        VStack {
            inputFields
            addButton
        }
    }
    
    private var inputFields: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Goal", text: $titleOfGoal)
                .customTextFieldStyle()
                .font(.system(.largeTitle, design: .default).weight(.bold))

            pickerSection(title: "Repeat", options: timeHorizonOptions, selection: $timeHorizon)
            pickerSection(title: "Measurement", options: GoalMeasure.allCases.map { $0.displayName }, selection: Binding<String>(get: { goalMeasure.displayName }, set: { goalMeasure = GoalMeasure(rawValue: $0) ?? .practiceSessions }))
            
            goalMeasureInput
        }
        .padding()
    }
    
    @ViewBuilder
    private var goalMeasureInput: some View {
        switch goalMeasure {
        case .practiceSessions:
            TextField("Number of Sessions", text: $numberOfSessions)
                .keyboardType(.numberPad)
                .customTextFieldStyle()
        case .practiceTime:
            practiceTimeInput
        case .patterns:
            TextField("Number of Patterns", text: $numberOfPatterns)
                .keyboardType(.numberPad)
                .customTextFieldStyle()
        }
    }
    
    private var practiceTimeInput: some View {
        HStack {
            TextField("Hours", text: $practiceHours)
                .keyboardType(.numberPad)
                .customTextFieldStyle()
                .onReceive(practiceHours.publisher.collect()) {
                    practiceHours = String($0.prefix(2)).filter { "0123456789".contains($0) }
                }
            
            TextField("Minutes", text: $practiceMinutes)
                .keyboardType(.numberPad)
                .customTextFieldStyle()
                .onReceive(practiceMinutes.publisher.collect()) {
                    let filtered = String($0.prefix(2)).filter { "0123456789".contains($0) }
                    practiceMinutes = Int(filtered) ?? 0 > 59 ? "59" : filtered
                }
        }
    }
    
    private func pickerSection(title: String, options: [String], selection: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title).bold()
                .padding(.vertical, 5)
            
            customPicker(options: options, selection: selection)
        }
    }

    private var addButton: some View {
        Button(action: addGoal) {
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

    private func addGoal() {
        // Placeholder action, replace with actual implementation
        print("Goal added")
    }

    // Reusable custom picker component
    func customPicker(options: [String], selection: Binding<String>) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .padding()
                        .frame(minHeight: 44, alignment: .center)
                        .background(self.backgroundForOption(option, selectedOption: selection.wrappedValue))
                        .cornerRadius(10)
                        .foregroundColor(option == selection.wrappedValue ? .white : .primary)
                        .font(.system(size: 18, weight: .bold))
                        .onTapGesture {
                            selection.wrappedValue = option
                        }
                }
            }
        }
    }
    
    // Background view for custom picker options
    func backgroundForOption(_ option: String, selectedOption: String) -> some View {
        LinearGradient(gradient: Gradient(colors: option == selectedOption ? [Color.blue, Color.purple] : [Color.gray.opacity(0.3), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)
    }
}
