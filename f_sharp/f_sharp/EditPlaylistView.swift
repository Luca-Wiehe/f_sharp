import SwiftUI

struct EditPlaylistView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    @State private var selectedPattern: String? = "Pattern 1"
    @State private var dummyPatterns = ["Pattern 1", "Pattern 2", "Pattern 3", "Pattern 4", "Pattern 5", "Pattern 6", "Pattern 7", "Pattern 8", "Pattern 9", "Pattern 10", "Pattern 11", "Pattern 12", "Pattern 13", "Pattern 14", "Pattern 15", "Pattern 16"]
    @State private var patternsExpanded: Bool = true

    private let sidebarGradient = LinearGradient(
        gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    private var backButton: some View {
        Button(action: {
            practiceViewManager.currentView = .home
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            NavigationStack {
                HStack(spacing: 0) {
                    VStack {
                        backButton
                            .padding(.vertical, 32)
                            .padding(.horizontal, 16)
                        ScrollView {
                            // PlaylistSettings button
                            SidebarButton(isExpandable: false, icon: "gear", text: "Playlist Settings", isExpanded: .constant(false))

                            SidebarButton(isExpandable: true, icon: "music.note.list", text: "Patterns", isExpanded: $patternsExpanded)

                            if patternsExpanded {
                                LazyVStack {
                                    NewPatternButton(action: {
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
                        PatternView(patternText: selectedPattern)
                            .frame(width: UIScreen.main.bounds.width * 0.7)
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

struct RoundedSidebar: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SidebarButton: View {
    let isExpandable: Bool
    let icon: String
    let text: String
    @Binding var isExpanded: Bool

    var body: some View {
        Button(action: {
            if isExpandable {
                self.isExpanded.toggle()
            }
        }) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(.leading, 24)

                Text(text)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                    .padding(.vertical, isExpandable ? 16 : 0)
                
                Spacer()
                
                if isExpandable {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.trailing, 16)
                }
            }
        }
    }
}

struct NewPatternButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("New Pattern")
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 5, dash: [10]))
                    .foregroundColor(.white)
            )
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

// Preview
struct EditPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlaylistView()
            .environmentObject(PracticeViewManager())
    }
}
