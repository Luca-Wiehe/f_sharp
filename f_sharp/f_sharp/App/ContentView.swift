import SwiftUI

struct ContentView: View {
    @EnvironmentObject var popupManager: PopupManager
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    @State var currentTab: Int = 0
    
    var body: some View {
        TabView (selection: $currentTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            PracticeView()
                .tabItem {
                    Label("Practice", systemImage: "pianokeys")
                }
                .tag(1)
            
            ListenView()
                .tabItem {
                    Label("Listen", systemImage: "headphones")
                }
                .tag(2)

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(3)

            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(4)
        }
        .overlay(
            PopupComponent(isShown: $popupManager.isShown) {
                popupManager.content
            }
        )
        .background(Color(UIColor.secondarySystemBackground))
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PopupManager())
            .environmentObject(PracticeViewManager())
    }
}
