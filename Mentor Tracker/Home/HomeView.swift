import SwiftUI

// Home
struct HomeView: View {
    @EnvironmentObject var mentorData: MentorData
    @EnvironmentObject var eventData: EventData
    
    // Body
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    header
                        .padding(.top, Constants.headerTopPadding)
                    DraggableStoryRow()
                }
                .padding()
                EventList()
                Spacer()
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    notificationButton
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // Notification button
    private var notificationButton: some View {
        Button {
        } label: {
            Image(systemName: "bell")
        }
    }
    
    // Header
    private var header: some View {
        VStack {
            HStack {
                Text(dateString)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
    
    // Get date string
    private var dateString: String {
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .long

        return formatter.string(from: now)
    }
    
    // Constants
    private struct Constants {
        static let headerTopPadding: CGFloat = -20
        static let aspectRatio: CGFloat = 3 / 2
        static let minCardSize: CGFloat = 80
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    static var eventData = EventData(named: "Default")
    
    static var previews: some View {
        HomeView()
            .environmentObject(mentorData)
            .environmentObject(eventData)
    }
}
