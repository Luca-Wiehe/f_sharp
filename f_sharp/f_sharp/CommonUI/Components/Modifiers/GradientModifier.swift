import SwiftUI

struct GradientOptions: OptionSet {
    let rawValue: Int
    
    static let stroke = GradientOptions(rawValue: 1 << 0)
    static let contentAndText = GradientOptions(rawValue: 1 << 1)
    static let background = GradientOptions(rawValue: 1 << 2)
}

struct GradientModifier: ViewModifier {
    var gradientColors: [Color]
    var options: GradientOptions
    var strokeWidth: CGFloat

    func body(content: Content) -> some View {
        let gradient = LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing)

        content
            .background(options.contains(.background) ? AnyView(gradient.cornerRadius(20)) : AnyView(EmptyView()))
            .foregroundColor(options.contains(.background) ? .white : .none)
            .overlay(
                options.contains(.contentAndText) ? AnyView(gradient.mask(content)) : AnyView(EmptyView())
            )
            .overlay(
                options.contains(.stroke) ?
                    AnyView(RoundedRectangle(cornerRadius: 20).stroke(gradient, lineWidth: strokeWidth)) :
                    AnyView(EmptyView())
            )
    }
}

extension View {
    func gradientModifier(gradientColors: [Color], options: GradientOptions, strokeWidth: CGFloat) -> some View {
        modifier(GradientModifier(gradientColors: gradientColors, options: options, strokeWidth: strokeWidth))
    }
}
