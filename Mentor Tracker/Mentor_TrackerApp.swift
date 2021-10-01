import SwiftUI

@main
struct Mentor_TrackerApp: App {
    @StateObject var mentorData = MentorData(named: "Default")
    @StateObject var eventData = EventData(named: "Default")
    
    // Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mentorData)
                .environmentObject(eventData)
        }
    }
}
