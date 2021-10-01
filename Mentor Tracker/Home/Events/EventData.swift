import Foundation

// Event data
class EventData: ObservableObject {
    let name: String
    
    // Events
    @Published var events = [Event]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    // Chronological events (kinda)
    var chronologicalEvents: [Event] {
        events.sorted { e1, e2 in
            return e1.day < e2.day
        }
    }
    
    // User defaults key
    private var userDefaultsKey: String {
        "EventData:" + name
    }
    
    // Init
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if events.isEmpty {
            addEvent(mentorID: 3, day: 9, month: "June", year: 2021)
            addEvent(mentorID: 2, day: 10, month: "June", year: 2021)
            addEvent(mentorID: 4, day: 12, month: "June", year: 2021)
        }
    }
    
    // Store in user defaults
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(events), forKey: userDefaultsKey)
    }
    
    // Restore from user defaults
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey), let decodedEvents = try? JSONDecoder().decode(Array<Event>.self, from: jsonData) {
            events = decodedEvents
        }
    }
    
    // MARK: - Intent
    
    // Get event
    func event(at index: Int) -> Event {
        let safeIndex = min(max(index, 0), events.count - 1)
        return events[safeIndex]
    }
    
    // Add event
    func addEvent(mentorID: Int, day: Int, month: String, year: Int) {
        let unique = (events.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let event = Event(id: unique, mentorID: mentorID, day: day, month: month, year: year)
        events.append(event)
    }
    
    // Add empty event
    func addEmptyEvent(mentorID: Int) {
        addEvent(mentorID: mentorID, day: 1, month: "January", year: 2000)
    }
}
