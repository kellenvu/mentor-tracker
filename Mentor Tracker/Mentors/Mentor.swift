import SwiftUI

// Mentor
struct Mentor: Hashable, Codable, Identifiable {
    let id: Int
    var firstName: String = ""
    var lastName: String = ""
    var headline: String = ""
    var email: String = ""
    var phone: String = ""
    var address1: String = ""
    var address2: String = ""
    var meetingContext: String = ""
    var imageName: String?
    var isFavorite: Bool = false
    
    // Get full name
    var fullName: String {
        var result = firstName + " " + lastName
        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
        return result
    }
    
    // Get address {
    var address: String {
        var result = address1 + "\n" + address2
        result = result.trimmingCharacters(in: .whitespacesAndNewlines)
        return result
    }
    
    // Get image
    var image: Image? {
        if let imageName = imageName {
            return Image(imageName)
        }
        else {
            return nil
        }
    }
}
