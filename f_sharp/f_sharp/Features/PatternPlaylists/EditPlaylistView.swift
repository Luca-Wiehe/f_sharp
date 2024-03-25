import SwiftUI

struct EditPlaylistView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    @Binding var currentPlaylist: PatternPlaylist
    
    @State private var patterns: [Pattern] = PatternStorage.shared.loadPatterns()
    @State private var selectedPattern: Pattern?
    @State private var patternsExpanded: Bool = true
    @State private var isPatternInEdit: Bool = false

    private let sidebarGradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                HStack(spacing: 0) {
                    VStack {
                        BackButton(
                            action: {
                            practiceViewManager.currentView = .home
                            }, color: .white)
                        .padding(.vertical, 32)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView {
                            PrimarySidebarElement(isExpandable: false, icon: "gear", text: "Playlist Settings", isExpanded: .constant(false))

                            PrimarySidebarElement(isExpandable: true, icon: "music.note.list", text: "Patterns", isExpanded: $patternsExpanded)

                            if patternsExpanded {
                                LazyVStack {
                                    SidebarActionElement(
                                        actionTitle: "New Pattern",
                                        action: {
                                            let newPattern = Pattern(musicXML: "")
                                            PatternStorage.shared.addPattern(newPattern)
                                            
                                            let playlistViewModel = PatternPlaylistViewModel(playlist: currentPlaylist)
                                            playlistViewModel.addPattern(newPattern)
                                            selectedPattern = newPattern
                                            
                                            patterns = PatternStorage.shared.loadPatterns()
                                        }
                                    )

                                    
                                    ForEach(Array(patterns.enumerated()), id: \.element.id) { index, pattern in
                                        Button(action: {
                                            self.selectedPattern = pattern
                                        }) {
                                            HStack {
                                                Text("Pattern \(index + 1)")
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 48)
                                                    .padding(.vertical, 16)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(self.selectedPattern?.id == pattern.id ? Color.white.opacity(0.3) : Color.clear)
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                    }
                    .background(sidebarGradient)
                    .clipShape(RoundedSidebar(radius: 20, corners: [.topRight, .bottomRight]))

                    if selectedPattern != nil {
                        if self.isPatternInEdit {
                            EditPatternView(onSave: {
                                self.isPatternInEdit = false
                            }, onCancel: {
                                self.isPatternInEdit = false
                            })
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                        }else {
                            PatternView(onEdit: {
                                self.isPatternInEdit = true
                            })
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                        }
                        
                    } else {
                        Text("Create a new pattern")
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// Preview
struct EditPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        let currentPlaylist: PatternPlaylist = PatternPlaylist(title: "Hello World", genre: "Rock", patternReferences: [], maxLength: 10)
        
        EditPlaylistView(currentPlaylist: .constant(currentPlaylist))
            .environmentObject(PracticeViewManager())
            .environmentObject(PlaylistStorage.shared)
    }
}
