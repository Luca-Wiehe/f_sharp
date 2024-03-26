import SwiftUI

struct ManagePlaylistsView: View {
    @State private var playlists: [PatternPlaylist] = PlaylistStorage.shared.loadPlaylists()
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    var body: some View {
        VStack (alignment: .leading) {
            BackButton(action: {
                practiceViewManager.currentView = .home
            })
            .padding(.vertical, 16)
            .padding(.leading, 32)
            
            Text("Pattern Playlists")
                .font(.system(size: 48, weight: .heavy, design: .default))
                .padding(.horizontal, 32)
            
            List {
                
                ForEach(playlists) { playlist in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(playlist.title)
                                .font(.headline)
                            Text(playlist.genre)
                                .font(.subheadline)
                            Text("Patterns: \(playlist.patternReferences.count)")
                                .font(.footnote)
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                // Implement Edit functionality
                            }) {
                                Image(systemName: "pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Button(action: {
                                // Implement Delete functionality
                                self.removePlaylist(playlist)
                            }) {
                                Image(systemName: "trash")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
    }
    
    private func removePlaylist(_ playlist: PatternPlaylist) {
        
    }
}

#Preview {
    ManagePlaylistsView()
        .environmentObject(PracticeViewManager())
}
