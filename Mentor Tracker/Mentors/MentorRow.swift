import SwiftUI

// Mentor row
struct MentorRow: View {
    let mentor: Mentor;
    
    // Body
    var body: some View {
        HStack {
            CircleImage(image: mentor.image, size: Constants.imageSize)
            VStack(alignment: .leading) {
                Text(mentor.fullName).bold()
                if !mentor.headline.isEmpty {
                    Text(mentor.headline)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            if mentor.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, Constants.verticalPadding)
    }
    
    // Constants
    private struct Constants {
        static let imageSize: CGFloat = 75
        static let verticalPadding: CGFloat = 3
    }
}

// Preview
struct MentorRow_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        MentorRow(mentor: mentorData.mentors[0])
            .environmentObject(mentorData)
    }
}
