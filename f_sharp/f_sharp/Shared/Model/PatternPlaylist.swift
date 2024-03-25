import Foundation

// Playlist struct definition
struct PatternPlaylist: Identifiable, Codable {
    var id = UUID()
    var title: String
    var genre: String
    var patternReferences: [UUID]
    var maxLength: Int
    var previewImageName: String {
            "genre-\(genre.lowercased())"
        }

    // Initialize the Playlist struct with all properties
    init(title: String, genre: String, patternReferences: [UUID], maxLength: Int) {
        self.title = title
        self.genre = genre
        self.patternReferences = patternReferences
        self.maxLength = maxLength
    }
}

