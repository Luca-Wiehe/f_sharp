import SwiftUI

struct EditPlaylistView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager

    var body: some View {
        VStack {
            // Your EditPlaylistView content here
            Button("Back") {
                practiceViewManager.currentView = .home
            }
        }
    }
}
