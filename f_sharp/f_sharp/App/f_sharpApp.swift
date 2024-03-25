//
//  f_sharpApp.swift
//  f_sharp
//
//  Created by Luca Wiehe on 20.02.24.
//

import SwiftUI

@main
struct f_sharpApp: App {
    var popupManager = PopupManager()
    var practiceViewManager = PracticeViewManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(popupManager)
                .environmentObject(practiceViewManager)
                .environmentObject(PlaylistStorage.shared)
        }
    }
}
