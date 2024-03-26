import SwiftUI

struct PlaylistOverviewView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    @State private var playlists: [PatternPlaylist] = PlaylistStorage.shared.loadPlaylists()
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        VStack (alignment: .leading) {
            BackButton(action: {
                practiceViewManager.currentView = .home
            })
            .padding(.top, 16)
            .padding(.leading, 32)
            
            Text("Pattern Playlists")
                .font(.system(size: 48, weight: .heavy, design: .default))
                .padding(32)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(playlists) { playlist in
                        NewPlaylistCardView(playlist: playlist)
                    }
                }
                .padding(.horizontal, 32)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct NewPlaylistCardView: View {
    var playlist: PatternPlaylist
    
    var body: some View {
        VStack(spacing: 0) {
            Image(playlist.previewImageName)
                .resizable()
                .scaledToFill()
                // Removed the fixed frame width and height
                .cornerRadius(10, corners: [.topLeft, .topRight])
            
            ZStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(playlist.genre.uppercased())
                            .foregroundColor(.secondary)
                            .font(.headline)
                        Text(playlist.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    // Placeholder for a button or other interactive element
                }
                .padding()
            }
            .frame(height: 80) // Keep the height to maintain design
            .background(Color(UIColor.secondarySystemBackground))
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        // Apply a dynamic width here if necessary, or let it be determined by the grid layout
    }
}



#Preview {
    PlaylistOverviewView()
}
