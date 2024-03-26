import SwiftUI

class PracticeViewManager: ObservableObject {
    @Published var currentView: PracticeViewState = .home
    @Published var currentPlaylistSelection: PatternPlaylist?
}

enum PracticeViewState {
    case home, editPlaylist, playlistOverview
}
