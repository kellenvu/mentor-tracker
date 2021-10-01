import SwiftUI

// Storify
// Create the outline around a story
struct Storify: ViewModifier {
    let size: CGFloat
    
    // Body
    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().strokeBorder(Color.white, lineWidth: size * 0.04))
            .overlay(Circle().strokeBorder(Color.blue, lineWidth: size * 0.02))
    }
}

// Storify extension
extension View {
    func storify(size: CGFloat) -> some View {
        self.modifier(Storify(size: size))
    }
}

// Preview
struct Storify_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        mentorData.mentors[0].image!
            .resizable()
            .storify(size: 500)
    }
}
