import SwiftUI

struct TimeSignature: View {
    var beatsPerMeasure: Int
    var beatType: Int

    private func viewForDigit(_ digit: Int) -> some View {
        switch digit {
        case 1:
            return AnyView(One())
        case 2:
            return AnyView(Two())
        case 3:
            return AnyView(Three())
        case 4:
            return AnyView(Four())
        case 5:
            return AnyView(Five())
        case 6:
            return AnyView(Six())
        case 7:
            return AnyView(Seven())
        case 8:
            return AnyView(Eight())
        case 9:
            return AnyView(Nine())
        default:
            return AnyView(EmptyView())
        }
    }
    
    private func viewsForNumber(_ number: Int) -> some View {
        let digits = Array(String(number))

        return GeometryReader { geometry in
            let availableWidth = geometry.size.width
            let digitWidth = digits.count > 1 ? availableWidth / CGFloat(digits.count) : availableWidth / 2
            let alignment: Alignment = digits.count > 1 ? .leading : .center

            HStack(spacing: 0) {
                if digits.count == 1 {
                    Spacer() // Add Spacer to center the single digit
                }
                ForEach(digits, id: \.self) { char in
                    if let digit = Int(String(char)) {
                        viewForDigit(digit)
                            .frame(width: digitWidth)
                    }
                }
                if digits.count == 1 {
                    Spacer() // Add Spacer to center the single digit
                }
            }
            .frame(width: availableWidth, alignment: alignment)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            let totalHeight = geometry.size.height
            let componentHeight = totalHeight / 2
            let availableWidth = geometry.size.width

            VStack(spacing: 4) {
                viewsForNumber(beatsPerMeasure)
                    .frame(height: componentHeight)
                viewsForNumber(beatType)
                    .frame(height: componentHeight)
            }
            .frame(width: availableWidth, height: totalHeight, alignment: .center)
        }
    }
}

struct TimeSignature_Previews: PreviewProvider {
    static var previews: some View {
        TimeSignature(beatsPerMeasure: 12, beatType: 4)
            .previewLayout(.fixed(width: 330, height: 750))
    }
}
