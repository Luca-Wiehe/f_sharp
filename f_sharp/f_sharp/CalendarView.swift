import SwiftUI

struct CalendarView: View {
    @State private var currentDate = Date()
    private let today = Date() // Store today's date to compare with currentDate
    
    private var daysInMonth: [String] {
        let totalDays = Calendar.current.range(of: .day, in: .month, for: currentDate)!.count
        let components = Calendar.current.dateComponents([.year, .month], from: currentDate)
        let firstOfMonth = Calendar.current.date(from: components)!
        let weekdayOfFirst = Calendar.current.component(.weekday, from: firstOfMonth)
        let offset = (weekdayOfFirst + 5) % 7 // Adjusting for Monday start
        var days = Array(repeating: "", count: offset) + (1...totalDays).map { String($0) }
        
        // Ensure the grid always has 6 rows
        let totalCells = 6 * 7 // 6 rows, 7 columns
        days.append(contentsOf: Array(repeating: "", count: totalCells - days.count))
        
        return days
    }
    
    private var currentDay: String {
        String(Calendar.current.component(.day, from: today))
    }
    
    private let weekdays: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    private func monthTitle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: currentDate)
    }
    
    private func goToPreviousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
            currentDate = newDate
        }
    }
    
    private func goToNextMonth() {
        let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
        if nextMonth <= Date() {
            currentDate = nextMonth
        }
    }
    
    private func isToday(date: String) -> Bool {
        guard let day = Int(date), !date.isEmpty else { return false }
        let components = Calendar.current.dateComponents([.year, .month, .day], from: today)
        let todayComponents = Calendar.current.dateComponents([.year, .month], from: currentDate)
        
        return components.year == todayComponents.year && components.month == todayComponents.month && components.day == day
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: goToPreviousMonth) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text(monthTitle())
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: goToNextMonth) {
                    Image(systemName: "chevron.right")
                }
                .disabled(Calendar.current.isDateInToday(currentDate) || Calendar.current.compare(currentDate, to: Date(), toGranularity: .month) == .orderedDescending)
            }
            .padding()
            
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(Array(weekdays.enumerated()), id: \.offset) { _, day in
                        Text(day)
                            .frame(width: 40, height: 40)
                    }
                }
                Divider().background(Color(red: 0.9, green: 0.9, blue: 0.9))
            }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(daysInMonth, id: \.self) { day in
                    Text(day)
                        .frame(width: 40, height: 40)
                        .background(isToday(date: day) ? Circle().fill(Color(red: 0.99, green: 0.99, blue: 0.99)) : Circle().fill(Color.clear))
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.7, green: 0.7, blue: 0.7), lineWidth: isToday(date: day) ? 1 : 0)
                        )
                }
            }
        }
        .padding()
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.width > 100 {
                    // Swipe right (previous month)
                    goToPreviousMonth()
                } else if value.translation.width < -100 {
                    // Swipe left (next month)
                    goToNextMonth()
                }
            }
        )
    }
}
