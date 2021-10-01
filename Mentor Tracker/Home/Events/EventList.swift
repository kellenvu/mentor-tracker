import SwiftUI

// Event list
struct EventList: View {
    @EnvironmentObject var mentorData: MentorData
    @EnvironmentObject var eventData: EventData
    
    // Body
    var body: some View {
        List {
            ForEach(eventData.chronologicalEvents) { event in
                EventRow(event: event)
            }
            .onDelete { indexSet in
                let eventToDelete = eventData.chronologicalEvents[indexSet.first!]
                eventData.events.remove(eventToDelete)
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    static var eventData = EventData(named: "Default")
    
    static var previews: some View {
        EventList()
            .environmentObject(mentorData)
            .environmentObject(eventData)
    }
}
