import Foundation

class PatternPlaylistViewModel {
    private var playlist: PatternPlaylist
    
    init(playlist: PatternPlaylist) {
        self.playlist = playlist
    }
    
    func addPattern(_ pattern: Pattern) {
        if !playlist.patternReferences.contains(pattern.id) {
            playlist.patternReferences.append(pattern.id)
            
            PlaylistStorage.shared.updatePlaylist(self.playlist)
        }
    }
    
    func removePattern(_ pattern: Pattern) {
        playlist.patternReferences = playlist.patternReferences.filter { $0 != pattern.id }
        PlaylistStorage.shared.updatePlaylist(self.playlist)
    }
    
    func getPatternIds() -> [UUID] {
        return playlist.patternReferences
    }
}
