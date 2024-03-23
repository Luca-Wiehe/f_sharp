import SwiftUI

class PracticeViewManager: ObservableObject {
    @Published var currentView: PracticeViewState = .home
}

enum PracticeViewState {
    case home, editPlaylist
}
