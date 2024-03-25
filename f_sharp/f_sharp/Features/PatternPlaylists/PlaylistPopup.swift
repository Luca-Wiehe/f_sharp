import SwiftUI

struct PlaylistPopup: View {
    @EnvironmentObject var popupManager: PopupManager
    @EnvironmentObject var practiceViewManager: PracticeViewManager
    @EnvironmentObject var playlistStorage: PlaylistStorage
    
    @State private var playlistName: String = ""
    @State private var selectedGenre: String = "Jazz"
    let genreOptions = ["Jazz", "Rock", "Classic", "Pop", "Other", "Electronic", "Hip Hop", "Blues"]

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Playlist Name", text: $playlistName)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .foregroundColor(.primary)
                    .cornerRadius(10)
                    .font(.system(.largeTitle, design: .default).weight(.bold))
                
                Text("Genre")
                    .font(.title).bold()
                    .padding(.bottom, 5)

                customPicker(options: genreOptions, selection: $selectedGenre)
            }
            .padding()

            Button(action: {
                popupManager.isShown = false
                practiceViewManager.currentView = .editPlaylist
                playlistStorage.addPlaylist(
                    PatternPlaylist(
                        title: playlistName,
                        genre: selectedGenre,
                        patternReferences: [],
                        maxLength: 10
                    )
                )
            }) {
                Text("Add Playlist")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }

    func customPicker(options: [String], selection: Binding<String>) -> some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

        return ScrollView(.vertical) {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(self.backgroundForOption(option, selectedOption: selection.wrappedValue))
                        .cornerRadius(10)
                        .foregroundColor(option == selection.wrappedValue ? .white : .primary)
                        .font(.system(size: 18, weight: .bold))
                        .onTapGesture {
                            selection.wrappedValue = option
                        }
                }
            }
        }
    }


    func backgroundForOption(_ option: String, selectedOption: String) -> some View {
        LinearGradient(gradient: Gradient(colors: option == selectedOption ? [Color.blue, Color.purple] : [Color.gray.opacity(0.3), Color.gray.opacity(0.3)]), startPoint: .leading, endPoint: .trailing)
    }
}
