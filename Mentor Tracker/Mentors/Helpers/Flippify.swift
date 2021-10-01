import SwiftUI

// Flippify
// Crop it into a circle
// Add a shadow
// When you tap, it does a flip
struct Flippify: AnimatableModifier {
    var size: CGFloat
    var rotation: Double // Degrees
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    // Body
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(Color.white, lineWidth: Constants.borderWidth))
            .shadow(radius: Constants.shadowRadius)
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    // Constants
    struct Constants {
        static let borderWidth: CGFloat = 4
        static let shadowRadius: CGFloat = 3
    }
}

// Flippify extension
extension View {
    func flippify(size: CGFloat, rotation: Double) -> some View {
        self.modifier(Flippify(size: size, rotation: rotation))
    }
}

// Preview
/*
struct Flippify_Previews: PreviewProvider {
    static var previews: some View {
        Flippify()
    }
}
*/
