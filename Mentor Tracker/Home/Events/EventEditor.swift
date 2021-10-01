import SwiftUI

// Event editor
struct EventEditor: View {
    @EnvironmentObject var mentorData: MentorData
    @EnvironmentObject var eventData: EventData
    @Environment(\.presentationMode) var presentationMode
    @Binding var event: Event
    let mentorID: Int
    
    // Body
    var body: some View {
        NavigationView {
            Form {
                Text("Make sure to press \"Return\" after each field!")
                    .center()
                Section(header: Text("Day")) {
                    TextField("Day", value: $event.day, formatter: NumberFormatter())
                }
                Section(header: Text("Month")) {
                    TextField("Month", text: $event.month)
                }
                Section(header: Text("Year")) {
                    TextField("Year", value: $event.year, formatter: NumberFormatter())
                }
            }
            .navigationTitle("Create Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    doneButton
                }
            }
        }
    }
    
    // Done button
    private var doneButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done").bold()
        }
    }
}

// Preview
/*
struct EventEditor_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    static var eventData = EventData(named: "Default")
    
    static var previews: some View {
        EventEditor(mentorID: mentorData.mentor(at: 0).id)
            .environmentObject(mentorData)
            .environmentObject(eventData)
    }
}
*/
