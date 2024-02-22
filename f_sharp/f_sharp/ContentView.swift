//
//  ContentView.swift
//  f_sharp
//
//  Created by Luca Wiehe on 20.02.24.
//

import SwiftUI
import SwiftSVG

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            Text("Practice")
                .tabItem {
                    Label("Practice", systemImage: "pianokeys")
                }
            
            Text("Listen")
                .tabItem {
                    Label("Listen", systemImage: "headphones")
                }

            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
