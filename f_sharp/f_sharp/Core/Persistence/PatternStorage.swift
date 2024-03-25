import Foundation

class PatternStorage: ObservableObject {
    static let shared = PatternStorage()
    private let fileName = "patterns.json"
    
    private var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var fileURL: URL {
        documentDirectory.appendingPathComponent(fileName)
    }
    
    @Published var patterns: [Pattern] = []
    
    init() {
        patterns = loadPatterns()
    }
    
    private func savePatterns() {
        do {
            let data = try JSONEncoder().encode(patterns)
            try data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error saving patterns: \(error)")
        }
    }
    
    func loadPatterns() -> [Pattern] {
        do {
            let data = try Data(contentsOf: fileURL)
            let patterns = try JSONDecoder().decode([Pattern].self, from: data)
            return patterns
        } catch {
            print("Error loading patterns: \(error)")
            return []
        }
    }
    
    func addPattern(_ pattern: Pattern) {
        patterns.append(pattern)
        savePatterns()
    }
    
    func deletePattern(_ patternID: UUID) {
        patterns.removeAll { $0.id == patternID }
        savePatterns()
    }
}
