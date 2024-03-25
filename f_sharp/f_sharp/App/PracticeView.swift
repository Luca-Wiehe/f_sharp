import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Practice")
                .font(.system(size: 48, weight: .heavy, design: .default))
                .padding(32)
            Spacer()
        }
    }
}

struct SubtitleView: View {
    var subtitle: String
    
    var body: some View {
            Text(subtitle)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 32)
        }
}

struct PlaylistCardView: View {
    var playlist: PatternPlaylist
    
    var body: some View {
        VStack(spacing: 0) {
            Image(playlist.previewImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
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
            .frame(height: 80)
            .background(Color(UIColor.secondarySystemBackground))
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

struct PlaylistManagerCardView: View {
    @EnvironmentObject var popupManager: PopupManager
    
    private let cardWidth: CGFloat = 200
    private let cardHeight: CGFloat = 230
    private let cornerRadius: CGFloat = 15
    private let buttonSize: CGSize = CGSize(width: 64, height: 64)
    private let manageButtonHeight: CGFloat = 48
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
            .frame(width: cardWidth, height: cardHeight)
            .shadow(radius: 10)
            .overlay(contentOverlay)
    }
    
    private var contentOverlay: some View {
        VStack {
            Spacer()

            HStack {
                actionButton(action: showAddNewPopup, icon: "plus", label: "Add New")
                    .padding(.leading, 8)

                Spacer()

                actionButton(action: viewAllPlaylists, icon: "list.bullet", label: "View All")
                    .padding(.trailing, 8)
            }

            Spacer()

            managePlaylistsButton
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    private func actionButton(action: @escaping () -> Void, icon: String, label: String) -> some View {
        VStack {
            Button(action: action) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.7))
                    .frame(width: buttonSize.width, height: buttonSize.height)
                    .overlay(
                        Image(systemName: icon)
                            .foregroundColor(.blue)
                    )
            }
            Text(label)
                .font(.caption)
                .foregroundColor(.white)
        }
    }
    
    private var managePlaylistsButton: some View {
        Button(action: managePlaylists) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white.opacity(0.7))
                .frame(height: manageButtonHeight)
                .overlay(
                    Text("Manage Playlists")
                        .foregroundColor(.blue)
                        .font(.headline)
                )
        }
    }
    
    private func showAddNewPopup() {
        @EnvironmentObject var practiceViewManager: PracticeViewManager
        
        popupManager.isShown = true
        popupManager.content = AnyView(PlaylistPopup())
    }

    private func viewAllPlaylists() {
        // Action to view all playlists
    }

    private func managePlaylists() {
        // Action to manage playlists
    }
}

struct PracticeHomeView: View {
    let playlists = [
        PatternPlaylist(title: "Playlist 1", genre: "Classic", patternReferences: ["Pattern 1A", "Pattern 1B"], maxLength: 5),
        PatternPlaylist(title: "Playlist 2", genre: "Jazz", patternReferences: ["Pattern 2A", "Pattern 2B"], maxLength: 10),
        PatternPlaylist(title: "Playlist 3", genre: "Rock", patternReferences: ["Pattern 3A", "Pattern 3B"], maxLength: 15)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HeaderView()
            
            SubtitleView(subtitle: "My Patterns")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    
                    PlaylistManagerCardView()

                    ForEach(playlists) { playlist in
                        PlaylistCardView(playlist: playlist)
                    }
                }
                .padding(.horizontal, 32)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(UIColor.systemBackground))
    }
}

// PracticeView implementation
struct PracticeView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager

    var body: some View {
        switch practiceViewManager.currentView {
        case .home:
            PracticeHomeView()
        case .editPlaylist:
            EditPlaylistView()
        }
    }
}
