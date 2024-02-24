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
                    HStack {
                        CalendarView()
                            .frame(width: UIScreen.main.bounds.width / 2 - 64, height: 400)
                            .padding(.trailing, 32)

                        GoalView()
                            .frame(width: UIScreen.main.bounds.width / 2 - 64, height: 400)
                    }
                }
            }
            .padding(.top, 16)
            
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
                    .padding(.horizontal, 40)
                    .padding(.vertical, 25)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(80)
                    .shadow(radius: 5)
                }
                .padding(.bottom, 16)
            }
        }
    }
}

// Preview provider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}