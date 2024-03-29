import SwiftUI

struct HomeView: View {
    
    // Existing dummy data for the scrollable lists
    let items = Array(repeating: "Item", count: 10)
    
    // New dummy list with some strings
    let dummyList: [String] = ["Hello World"]
    
    // Dummy data for weekly goals, replace with your actual data model
    @State var weeklyGoals = [
        ("circle", "Goal 1", false),
        ("circle", "Goal 2", false),
        ("circle", "Goal 3", false)
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Home")
                        .font(.system(size: 48, weight: .heavy, design: .default))
                        .padding(32)
                    
                    HStack {
                        CalendarView()
                            .frame(maxWidth: .infinity, idealHeight: 450)
                            .padding(.trailing, 16)

                        GoalView()
                            .frame(maxWidth: .infinity, idealHeight: 450)
                            .padding(.leading, 16)
                    }
                    .padding(.horizontal, 32)
                    
                    Text("Jump back in")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                }
            }
            
            if !dummyList.isEmpty {
                    Button(action: {
                        // Your action here
                    }) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 24))
                                .bold()
                                .padding(.trailing, 20)
                            Text("Review All (\(dummyList.count))")
                                .font(.system(size: 20))
                                .bold()
                        }
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(80)
                        .shadow(radius: 5)
                    }
                    .padding(.bottom, 16)
                    .padding(.trailing, 36)
                }
        }
        .background(Color(UIColor.systemBackground))
    }
}
