import SwiftUI

// Story circle
struct StoryCircle: View {
    var mentor: Mentor
    var size: CGFloat
    
    // Body
    var body: some View {
        VStack {
            if let image = mentor.image {
                image
                    .resizable()
                    .storify(size: size)
            }
            else {
                ConcentricRectangles()
                    .stroke()
                    .storify(size: size)
            }
            Text("\(mentor.firstName.isEmpty ? " " : mentor.firstName)")
        }
    }
}

// Preview
struct StoryCircle_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    static var mentor = mentorData.mentors[0]
    
    static var previews: some View {
        StoryCircle(mentor: mentor, size: 100)
    }
}
