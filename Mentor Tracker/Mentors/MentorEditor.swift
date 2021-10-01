import SwiftUI
import iPhoneNumberField

// Mentor editor
struct MentorEditor: View {
    @EnvironmentObject var mentorData: MentorData
    @Binding var mentor: Mentor
    @Environment(\.presentationMode) var presentationMode
    let navTitle: String
    @State private var isChoosingImage = false
    
    // Body
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    CircleImage(image: mentor.image, size: 125)
                        .center()
                    Button {
                        isChoosingImage = true
                    } label: {
                        Text("Edit")
                    }
                }
                .padding()
                basicInfoSection
                contactSection
            }
            .navigationTitle(navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
        }
        .sheet(isPresented: $isChoosingImage) {
            PhotoLibrary(handlePickedImage: { image in handlePickedImage(image) })
        }
    }
    
    // L15 handler for an image from camera or photo library
    private func handlePickedImage(_ image: UIImage?) {
        if let imageData = image?.jpegData(compressionQuality: 1.0) {
            // Set the photo here
        }
        isChoosingImage = false
    }
    
    // Done button
    private var doneButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done").bold()
        }
    }
    
    // Basic info section
    private var basicInfoSection: some View {
        Section(header: Text("Basic Information")) {
            TextField("First Name", text: $mentor.firstName)
            TextField("Last Name", text: $mentor.lastName)
            TextField("Headline", text: $mentor.headline)
        }
    }
    
    // Contact section
    private var contactSection: some View {
        Group {
            Section(header: Text("Phone Number")) {
                iPhoneNumberField("", text: $mentor.phone)
                    .maximumDigits(10)
            }
            Section(header: Text("Email")) {
                TextField("", text: $mentor.email)
            }
            Section(header: Text("Address")) {
                TextField("Line 1", text: $mentor.address1)
                TextField("Line 2", text: $mentor.address2)
            }
        }
    }
}

// Preview
struct MentorEditor_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        MentorEditor(mentor: .constant(mentorData.mentors[0]), navTitle: "Test")
            .environmentObject(mentorData)
    }
}
