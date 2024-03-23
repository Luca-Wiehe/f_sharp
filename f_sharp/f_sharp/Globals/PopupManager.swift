import SwiftUI

class PopupManager: ObservableObject {
    @Published var isShown: Bool = false
    @Published var content: AnyView = AnyView(EmptyView())
    
    func showPopup<Content: View>(@ViewBuilder content: @escaping () -> Content) {
        self.content = AnyView(content())
        self.isShown = true
    }
    
    func hidePopup() {
        self.isShown = false
    }
}
