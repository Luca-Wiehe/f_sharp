import SwiftUI

struct ContentView: View {
    @EnvironmentObject var popupManager: PopupManager
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            PracticeView()
                .tabItem {
                    Label("Practice", systemImage: "pianokeys")
                }
            
            ListenView()
                .tabItem {
                    Label("Listen", systemImage: "headphones")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .overlay(
            PopupComponent(isShown: $popupManager.isShown) {
                popupManager.content
            }
        )
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PopupManager())
    }
}
