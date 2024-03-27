import SwiftUI

struct ManagePlaylistsView: View {
    @State private var playlists: [PatternPlaylist] = PlaylistStorage.shared.loadPlaylists()
    @EnvironmentObject var practiceViewManager: PracticeViewManager

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                BackButton(action: {
                    practiceViewManager.currentView = .home
                })
                .padding(.vertical, 16)
                .background(Color(UIColor.systemGroupedBackground))

                Text("Manage Playlists")
                    .font(.system(size: 48, weight: .heavy, design: .default))
                    .background(Color(UIColor.systemGroupedBackground))

                LazyVStack(alignment: .leading, spacing: 8) {
                    ForEach(playlists) { playlist in
                        PlaylistItemView(
                            playlist: playlist,
                            editAction: {
                                practiceViewManager.currentPlaylistSelection = playlist
                                practiceViewManager.currentView = .editPlaylist
                            },
                            removeAction: {
                                PlaylistStorage.shared.deletePlaylist(playlist.id)
                                playlists = PlaylistStorage.shared.loadPlaylists()
                            }
                        )
                    }
                }
                .padding(.bottom, 32)
            }
        }
        .padding(.horizontal, 32)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

struct PlaylistItemView: View {
    var playlist: PatternPlaylist
    var editAction: () -> Void
    var removeAction: () -> Void

    var body: some View {
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
            HStack(spacing: 10) {
                Button(action: editAction) {
                    Image(systemName: "pencil")
                        .foregroundColor(Color.gray)
                        .fontWeight(.heavy)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding()
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Button(action: removeAction) {
                    Image(systemName: "trash")
                        .foregroundColor(Color.gray)
                        .fontWeight(.heavy)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding()
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(20)
    }
}



#Preview {
    ManagePlaylistsView()
        .environmentObject(PracticeViewManager())
}
