import SwiftUI

struct GoalPopup: View {
    @State private var titleOfGoal: String = ""
    @State private var timeHorizon: String = "Weekly"
    @State private var goalMeasure: String = "# Practice Sessions"
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    
    let timeHorizonOptions = ["Weekly", "Monthly"]
    let goalMeasureOptions = ["# Practice Sessions", "Practice Time", "# Patterns"]
    let hoursRange = Array(0...99)
    let minutesRange = Array(0...59)

    var body: some View {
        ScrollView {
            VStack {
            Section(header: Text("Goal Details")) {
                TextField("Title of Goal", text: $titleOfGoal)
                
                Picker("Time Horizon", selection: $timeHorizon) {
                    ForEach(timeHorizonOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Goal Measure", selection: $goalMeasure) {
                    ForEach(goalMeasureOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
                if goalMeasure == "Practice Time" {
                    Section(header: Text("Goal")) {
                        HStack {
                            Spacer() // Pushes content to center
                            
                            Picker("Hours", selection: $selectedHours) {
                                ForEach(hoursRange, id: \.self) {
                                    Text("\($0) hours")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 150)
                            .clipped()
                            
                            Picker("Minutes", selection: $selectedMinutes) {
                                ForEach(minutesRange, id: \.self) {
                                    Text("\($0) min")
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 150)
                            .clipped()
                            
                            Spacer() // Pushes content to center
                        }
                    }
                }
            }
        }
    }
}
