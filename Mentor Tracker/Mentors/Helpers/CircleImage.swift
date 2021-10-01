import SwiftUI

// Circle image
struct CircleImage: View {
    var image: Image?
    var size: CGFloat
    
    // Body
    var body: some View {
        if let image = image {
            image
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
        else {
            ConcentricRectangles()
                .stroke()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}
