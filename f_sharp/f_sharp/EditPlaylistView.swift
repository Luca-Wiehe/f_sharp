import SwiftUI

struct EditPlaylistView: View {
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    
    @State private var selectedPattern: String? = "Pattern 1"
    @State private var dummyPatterns = ["Pattern 1", "Pattern 2", "Pattern 3"]
    @State private var isExpanded: Bool = true

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
                        ScrollView {
                            backButton
                                .padding(.vertical, 32)
                                .padding(.horizontal, 16)
                            
                            // PlaylistSettings button
                            Button(action: {
                                // Action for PlaylistSettings
                            }) {
                                HStack {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                        .padding(.leading, 24)

                                    Text("Playlist Settings")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                    
                                    Spacer()
                                }
                            }
                            .padding(.bottom, 16)

                            Button(action: {
                                self.isExpanded.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "music.note.list")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.white)
                                        .padding(.leading, 24)

                                    Text("Patterns")
                                        .bold()
                                        .foregroundColor(.white)
                                        .padding(.leading, 8)
                                        .padding(.vertical)
                                    
                                    Spacer()

                                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding(.trailing, 16)
                                }
                            }

                            if isExpanded {
                                LazyVStack {
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
}

struct RoundedSidebar: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct PatternView: View {
    var patternText: String

    var body: some View {
        VStack {
            Text(patternText)
                .padding()
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
