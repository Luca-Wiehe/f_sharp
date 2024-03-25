import Foundation

class PlaylistViewModel: ObservableObject {
    @Published var patterns: [Pattern]
    
    init() {
        // Initial dummy data
        self.patterns = (1...3).map {
            Pattern(name: "Pattern \($0)")
        }
    }
    
    func addPattern() {
        let newPatternCount = patterns.count + 1
        let newPattern = Pattern(name: "Pattern \(newPatternCount)")
        patterns.append(newPattern)
    }
}
