import SwiftUI
import SwiftlySearch

// Mentor list
struct MentorList: View {
    @EnvironmentObject var mentorData: MentorData
    @State var searchText = ""
    @State private var mentorToEdit: Mentor?
    @State private var showFavoritesOnly = false
    
    // Body
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly.animation()) {
                    Text("Favorites only")
                }
                ForEach(filteredMentors) { mentor in
                    NavigationLink(destination: MentorProfile(mentor: $mentorData.mentors[mentor])) {
                        MentorRow(mentor: mentor)
                    }
                }
                .onDelete { indexSet in
                    let mentorToDelete = filteredMentors[indexSet.first!]
                    mentorData.mentors.remove(mentorToDelete)
                }
            }
            .navigationTitle("Mentors")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    plusButton
                }
            }
            .navigationBarSearch(self.$searchText)
        }
        .sheet(item: $mentorToEdit) { mentor in
            MentorEditor(mentor: $mentorData.mentors[mentor], navTitle: "Add Mentor")
        }
    }
    
    // Filtered mentors
    var filteredMentors: [Mentor] {
        mentorData.alphabeticalMentors.filter { mentor in
            (!showFavoritesOnly || mentor.isFavorite)
        }
        .filter { searchBarFilter(mentor: $0) }
    }
    
    // Plus button
    private var plusButton: some View {
        Button {
            mentorData.addEmptyMentor()
            mentorToEdit = mentorData.mentor(at: mentorData.mentors.count - 1)
        } label: {
            Image(systemName: "plus")
        }
    }
    
    // Search bar filter
    private func searchBarFilter(mentor: Mentor) -> Bool {
        if searchText.isEmpty {
            return true
        }
        else {
            return mentor.fullName.contains(searchText)
        }
    }
}

// Preview
struct MentorListView_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        MentorList()
            .environmentObject(mentorData)
    }
}
