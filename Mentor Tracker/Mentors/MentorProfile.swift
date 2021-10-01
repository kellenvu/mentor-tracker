import SwiftUI

// Mentor profile
struct MentorProfile: View {
    @EnvironmentObject var mentorData: MentorData
    @EnvironmentObject var eventData: EventData
    @Binding var mentor: Mentor
    
    @State private var eventToEdit: Event?
    @State private var mentorToEdit: Mentor?
    
    @State private var imageSize: CGFloat = Constants.smallImageSize
    @State private var imageRotation: Double = 0
    
    // Body
    var body: some View {
        List {
            Section {
                VStack {
                    CircleImageWithShadow(image: mentor.image, size: imageSize, rotation: imageRotation)
                        .center()
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                imageSize = (imageSize == Constants.largeImageSize) ? Constants.smallImageSize : Constants.largeImageSize
                                imageRotation = imageRotation + 180
                            }
                        }
                    HStack {
                        if mentor.fullName != "" {
                            Text(mentor.fullName)
                                .font(.largeTitle)
                        }
                        FavoriteButton(isSet: $mentorData.mentors[mentor].isFavorite)
                    }
                    Text(mentor.headline)
                        .foregroundColor(.secondary)
                }
                .padding()
                infoRow(name: "Phone", item: mentor.phone.isEmpty ? "--" : mentor.phone)
                infoRow(name: "Email", item: mentor.email.isEmpty ? "--" : mentor.email)
                infoRow(name: "Address", item: mentor.address.isEmpty ? "--" : mentor.address)
            }
            Section {
                reminderButton
            }
        }
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                editButton
            }
        }
        .sheet(item: $mentorToEdit) { mentor in
            MentorEditor(mentor: $mentorData.mentors[mentor], navTitle: "Edit Mentor")
        }
        .popover(item: $eventToEdit) { event in
            EventEditor(event: $eventData.events[event], mentorID: mentor.id)
        }
    }
    
    // Reminder button
    private var reminderButton: some View {
        Button {
            eventData.addEmptyEvent(mentorID: mentor.id)
            eventToEdit = eventData.event(at: eventData.events.count - 1)
        } label: {
            Text("Create a reminder")
        }
    }
    
    // Edit button
    private var editButton: some View {
        Button {
            mentorToEdit = mentorData.mentors[mentor]
        } label: {
            Text("Edit")
                .bold()
        }
    }
    
    // Info row
    private func infoRow(name: String, item: String?) -> some View {
        HStack {
            if let item = item {
                Text(name)
                Spacer()
                Text(item)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding(.vertical, Constants.verticalPadding)
    }
    
    // Constants
    private struct Constants {
        static let smallImageSize: CGFloat = 125
        static let largeImageSize: CGFloat = 250
        static let margin: CGFloat = 30
        static let verticalPadding: CGFloat = 5
    }
}

// Preview
struct MentorProfile_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        MentorProfile(mentor: .constant(mentorData.mentors[0]))
            .environmentObject(mentorData)
    }
}
