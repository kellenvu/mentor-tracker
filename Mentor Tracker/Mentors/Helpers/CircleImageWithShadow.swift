import SwiftUI

// Circle image
struct CircleImageWithShadow: View {
    var image: Image?
    var size: CGFloat
    var rotation: Double
    
    // Body
    var body: some View {
        if let image = image {
            image
                .resizable()
                .flippify(size: size, rotation: rotation)
        }
        else {
            ConcentricRectangles()
                .stroke()
                .flippify(size: size, rotation: rotation)
        }
    }
}
