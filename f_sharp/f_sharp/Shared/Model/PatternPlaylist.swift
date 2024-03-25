import Foundation

// Playlist struct definition
struct PatternPlaylist: Identifiable {
    var id = UUID()
    var title: String
    var genre: String
    var patternReferences: [String]
    var maxLength: Int
    var previewImageName: String {
            "genre-\(genre.lowercased())"
        }

    // Initialize the Playlist struct with all properties
    init(title: String, genre: String, patternReferences: [String], maxLength: Int) {
        self.title = title
        self.genre = genre
        self.patternReferences = patternReferences
        self.maxLength = maxLength
    }
}
