import SwiftUI

struct RestConfig {
    let sixteenthWidthRatio: CGFloat = 1.5
    let sixteenthHeightRatio: CGFloat = 3
    let eighthWidthRatio: CGFloat = 1.5
    let eighthHeightRatio: CGFloat = 3
    let quarterWidthRatio: CGFloat = 1.5
    let quarterHeightRatio: CGFloat = 3
    let halfAndFullWidthRatio: CGFloat = 1.5
    let halfAndFullHeightRatio: CGFloat = 0.5
    let halfOffsetRatioY: CGFloat = 0.35
    let fullOffsetRatioY: CGFloat = -0.35
}

struct RestSymbol: View {
    let lineSpacing: CGFloat
    let restDuration: NoteDuration
    let isDotted: Bool
    
    let restConfig = RestConfig()
    
    var body: some View {
        switch restDuration {
        case .sixteenth:
            EighthRest()
                .frame(width: restConfig.sixteenthWidthRatio * lineSpacing, height: restConfig.sixteenthHeightRatio * lineSpacing)
        case .eighth:
            EighthRest()
                .frame(width: restConfig.eighthWidthRatio * lineSpacing, height: restConfig.eighthHeightRatio * lineSpacing)
        case .quarter:
            QuarterRest()
                .frame(width: restConfig.quarterWidthRatio * lineSpacing, height: restConfig.quarterHeightRatio * lineSpacing)
        case .half:
            Rectangle()
                .frame(width: restConfig.halfAndFullWidthRatio * lineSpacing, height: restConfig.halfAndFullHeightRatio * lineSpacing)
                .offset(x: 0, y: restConfig.halfOffsetRatioY * lineSpacing)
        case .full:
            Rectangle()
                .frame(width: restConfig.halfAndFullWidthRatio * lineSpacing, height: restConfig.halfAndFullHeightRatio * lineSpacing)
                .offset(x: 0, y: restConfig.fullOffsetRatioY * lineSpacing)
        case .unknown:
            Circle()
        }
    }
}

#Preview {
    RestSymbol(lineSpacing: 15, restDuration: .full, isDotted: false)
}
