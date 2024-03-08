import SwiftUI

// Playlist struct definition
struct Playlist: Identifiable {
    var id = UUID()
    var title: String
    var genre: String
    var patternReferences: [String]
    var maxLength: Int
    var previewImage: Image {
            Image("genre-\(genre.lowercased())")
        }

    // Initialize the Playlist struct with all properties
    init(title: String, genre: String, patternReferences: [String], maxLength: Int, previewImage: Image) {
        self.title = title
        self.genre = genre
        self.patternReferences = patternReferences
        self.maxLength = maxLength
    }
}

// PracticeView implementation
struct PracticeView: View {
    @EnvironmentObject var popupManager: PopupManager
    
    let playlists = [
        Playlist(title: "Playlist 1", genre: "Classic", patternReferences: ["Pattern 1A", "Pattern 1B"], maxLength: 5, previewImage: Image(systemName: "music.note.list")),
        Playlist(title: "Playlist 2", genre: "Jazz", patternReferences: ["Pattern 2A", "Pattern 2B"], maxLength: 10, previewImage: Image(systemName: "music.quarternote.3")),
        Playlist(title: "Playlist 3", genre: "Rock", patternReferences: ["Pattern 3A", "Pattern 3B"], maxLength: 15, previewImage: Image(systemName: "music.note"))
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Practice")
                    .font(.system(size: 48, weight: .heavy, design: .default))
                    .padding(32)
                Spacer()
            }
            
            Text("My Patterns")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 32)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 200, height: 230)
                        .shadow(radius: 10)
                        .overlay(
                            VStack {
                                Spacer()

                                HStack {
                                    VStack {
                                        Button(action: {
                                            popupManager.isShown = true
                                            popupManager.content = AnyView(PlaylistPopup())
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white.opacity(0.7))
                                                .frame(width: 64, height: 64)
                                                .overlay(
                                                    Image(systemName: "plus")
                                                        .foregroundColor(.blue)
                                                )
                                        }
                                        Text("Add New")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.leading, 8)

                                    Spacer()
                                    
                                    VStack {
                                        Button(action: {
                                            // Action to view all playlists
                                        }) {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.white.opacity(0.7))
                                                .frame(width: 64, height: 64)
                                                .overlay(
                                                    Image(systemName: "list.bullet")
                                                        .foregroundColor(.blue)
                                                )
                                        }
                                        Text("View All")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.trailing, 8)
                                }

                                Spacer()
                                
                                Button(action: {
                                    // Action to manage playlists
                                }) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.7))
                                        .frame(height: 48)
                                        .overlay(
                                            Text("Manage Playlists")
                                                .foregroundColor(.blue)
                                                .font(.headline)
                                        )
                                }
                                .padding(.bottom, 16)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        )


                    ForEach(playlists) { playlist in
                        VStack(spacing: 0) {
                            playlist.previewImage
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 150)
                                .cornerRadius(10, corners: [.topLeft, .topRight])

                            ZStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(playlist.genre.uppercased()) // add uppercased for genre
                                            .foregroundColor(.secondary)
                                            .font(.headline)
                                        Text(playlist.title)
                                            .font(.title2) // adjust to your preference
                                            .fontWeight(.bold)
                                            .foregroundColor(.primary)
                                    }
                                    Spacer()
                                    Button(action: {
                                        // Action to download playlist
                                    }) {
                                        Image(systemName: "icloud.and.arrow.down") // use your download icon
                                            .foregroundColor(.blue)
                                            .font(.title2) // adjust to your preference
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
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
                .padding(.horizontal, 32)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(UIColor.systemBackground))
    }
}
