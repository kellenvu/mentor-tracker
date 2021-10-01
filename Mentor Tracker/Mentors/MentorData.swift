import Foundation

// Mentor data
class MentorData: ObservableObject {
    let name: String
    
    // Mentors
    @Published var mentors = [Mentor]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    // Alphabetical mentors
    var alphabeticalMentors: [Mentor] {
        mentors.sorted { m1, m2 in
            return m1.fullName < m2.fullName
        }
    }
    
    // User defaults key
    private var userDefaultsKey: String {
        "MentorData:" + name
    }
    
    // Init
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if mentors.isEmpty {
            addMentor(firstName: "Kellen", lastName: "Vu", headline: "Stanford", imageName: "Vu_Kellen")
            addMentor(firstName: "Paul", lastName: "Fisher", headline: "Stanford", imageName: "Fisher_Paul")
            addMentor(firstName: "Jennifer", lastName: "Raymond", headline: "Stanford", imageName: "Raymond_Jennifer")
            addMentor(firstName: "Mike", lastName: "Gisondi", headline: "Stanford", imageName: "Gisondi_Mike")
            addMentor(firstName: "Joe", lastName: "Garner", headline: "Stanford", imageName: "Garner_Joe")
            addMentor(firstName: "Poppy", lastName: "Crum", headline: "Stanford", imageName: "Crum_Poppy")
        }
    }
    
    // Store in user defaults
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(mentors), forKey: userDefaultsKey)
    }
    
    // Restore from user defaults
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey), let decodedMentors = try? JSONDecoder().decode(Array<Mentor>.self, from: jsonData) {
            mentors = decodedMentors
        }
    }
    
    // MARK: - Intent
    
    // Get mentor
    func mentor(at index: Int) -> Mentor {
        let safeIndex = min(max(index, 0), mentors.count - 1)
        return mentors[safeIndex]
    }
    
    // Add mentor
    func addMentor(firstName: String, lastName: String, headline: String, imageName: String?) {
        let unique = (mentors.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let mentor = Mentor(id: unique, firstName: firstName, lastName: lastName, headline: headline, imageName: imageName)
        mentors.append(mentor)
    }
    
    // Add empty mentor
    func addEmptyMentor() {
        addMentor(firstName: "", lastName: "", headline: "", imageName: nil)
    }
}
