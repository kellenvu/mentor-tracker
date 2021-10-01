import SwiftUI

// Event row
struct EventRow: View {
    @EnvironmentObject var mentorData: MentorData
    @EnvironmentObject var eventData: EventData
    let event: Event
    
    // Body
    var body: some View {
        if let mentor = mentor {
            ZStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(spacing: 10) {
                            Text("Upcoming").font(.headline)
                            Text("\(event.day - currentDay) days")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                        Text("Reach out to \(mentor.fullName) on \(event.date)!")
                    }
                    Spacer()
                    RoundRectImage(image: mentor.image, size: 100)
                        .padding(.leading, 20)
                }
                NavigationLink(destination: MentorProfile(mentor: $mentorData.mentors[mentor])) { }
            }
            .padding(.vertical)
        }
    }
    
    // Get associated mentor
    private var mentor: Mentor? {
        getMentorWithID(event.mentorID)
    }
    
    // Get mentor with ID
    private func getMentorWithID(_ id: Int) -> Mentor? {
        let index = mentorData.mentors.firstIndex(where: { $0.id == id })
        if let index = index {
            return mentorData.mentor(at: index)
        }
        else {
            return nil
        }
    }
    
    // Current day
    private var currentDay: Int {
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return Int(formatter.string(from: now)) ?? 0
    }
}

// Preview
struct EventRow_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    static var eventData = EventData(named: "Default")
    
    static var previews: some View {
        EventList()
            .environmentObject(mentorData)
            .environmentObject(eventData)
    }}
