import Foundation

class PlaylistStorage: ObservableObject {
    static let shared = PlaylistStorage()
    private let fileName = "playlists.json"
    
    private var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var fileURL: URL {
        documentDirectory.appendingPathComponent(fileName)
    }
    
    func savePlaylists(_ playlists: [PatternPlaylist]) {
        do {
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error saving playlists: \(error)")
        }
    }
    
    func loadPlaylists() -> [PatternPlaylist] {
        do {
            let data = try Data(contentsOf: fileURL)
            let playlists = try JSONDecoder().decode([PatternPlaylist].self, from: data)
            return playlists
        } catch {
            print("Error loading playlists: \(error)")
            return []
        }
    }
    
    func addPlaylist(_ playlist: PatternPlaylist) {
        var playlists = loadPlaylists()
        playlists.append(playlist)
        savePlaylists(playlists)
    }
    
    func deletePlaylist(_ playlistID: UUID) {
        var playlists = loadPlaylists()
        playlists.removeAll { $0.id == playlistID }
        savePlaylists(playlists)
    }
}
