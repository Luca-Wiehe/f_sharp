import Foundation

struct Pattern: Identifiable, Equatable, Codable {
    let id: UUID
    let musicXML: String

    init(id: UUID = UUID(), musicXML: String) {
        self.id = id
        self.musicXML = musicXML
    }
}
