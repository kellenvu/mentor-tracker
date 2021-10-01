import SwiftUI

// Concentric rectangles
struct ConcentricRectangles: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()

        for i in stride(from: 1, through: 200, by: 5) {
            let insetRect = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
                .insetBy(dx: CGFloat(i), dy: CGFloat(i))
            p.addRect(insetRect)
        }

        return p
    }
}

// Preview
struct ConcentricRectangles_Previews: PreviewProvider {
    static var previews: some View {
        ConcentricRectangles()
            .stroke()
            .frame(width: 200, height: 200)
    }
}
