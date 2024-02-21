//
//  ContentView.swift
//  f_sharp
//
//  Created by Luca Wiehe on 20.02.24.
//

import SwiftUI
import JavaScriptCore

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Home")
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

            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
