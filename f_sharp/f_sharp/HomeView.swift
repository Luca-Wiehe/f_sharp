import SwiftUI

struct HomeView: View {
    // Dummy data for the scrollable lists
    let items = Array(repeating: "Item", count: 10)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    CalendarView()
                        .frame(width: UIScreen.main.bounds.width / 2, height: 500)
                    
                    // Placeholder view
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: UIScreen.main.bounds.width / 2, height: 400)
                }
                
                Text("Jump back in")
                    .font(.headline)
                    .padding([.leading, .top])

                // Horizontally scrollable list with dummy elements
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<items.count, id: \.self) { index in
                            Text("\(items[index]) \(index + 1)")
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.leading, index == 0 ? 16 : 0) // Add padding to the first element
                        }
                    }
                }
                .frame(height: 120)

                // Another horizontally scrollable list with dummy elements
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<items.count, id: \.self) { index in
                            Text("\(items[index]) \(index + 1)")
                                .frame(width: 80, height: 80)
                                .background(Color.green)
                                .cornerRadius(10)
                                .padding(.leading, index == 0 ? 16 : 0) // Add padding to the first element
                        }
                    }
                }
                .frame(height: 100)
            }
        }
    }
}

#Preview{
    HomeView()
}
