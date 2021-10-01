import SwiftUI

// Round rectangle image
struct RoundRectImage: View {
    var image: Image?
    var size: CGFloat
    
    // Body
    var body: some View {
        let clipShape = RoundedRectangle(cornerRadius: 5)
        if let image = image {
            image
                .resizable()
                .frame(width: size, height: size)
                .clipShape(clipShape)
        }
        else {
            ConcentricRectangles()
                .stroke()
                .frame(width: size, height: size)
                .clipShape(clipShape)
        }
    }
}
