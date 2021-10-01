import Foundation

// Event
struct Event: Hashable, Codable, Identifiable {
    let id: Int
    var mentorID: Int
    var day: Int
    var month: String
    var year: Int
    
    // Date as string
    var date: String {
        "\(month) \(day), \(year)"
    }
}
