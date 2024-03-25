import SwiftUI

struct EditPlaylistView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    @State private var selectedPattern: String? = "Pattern 1"
    @State private var dummyPatterns = ["Pattern 1", "Pattern 2", "Pattern 3", "Pattern 4", "Pattern 5", "Pattern 6", "Pattern 7", "Pattern 8", "Pattern 9", "Pattern 10", "Pattern 11", "Pattern 12", "Pattern 13", "Pattern 14", "Pattern 15", "Pattern 16"]
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
                                        print("New Pattern button tapped")
                                    })
                                    
                                    ForEach(dummyPatterns, id: \.self) { pattern in
                                        Button(action: {
                                            self.selectedPattern = pattern
                                        }) {
                                            HStack {
                                                Text(pattern)
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 48)
                                                    .padding(.vertical, 16)

                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .background(self.selectedPattern == pattern ? Color.white.opacity(0.3) : Color.clear)
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

                    if let selectedPattern = selectedPattern {
                        if self.isPatternInEdit {
                            EditPatternView(onSave: {
                                self.isPatternInEdit = false
                            }, onCancel: {
                                self.isPatternInEdit = false
                            })
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                        }else {
                            PatternView(patternText: selectedPattern, onEdit: {
                                self.isPatternInEdit = true
                            })
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                        }
                        
                    } else {
                        Text("Select a pattern")
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
        EditPlaylistView()
            .environmentObject(PracticeViewManager())
    }
}
