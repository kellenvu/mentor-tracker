import SwiftUI

// Content View
struct ContentView: View {
    @State private var selection: Tab = .home
    
    // Tab
    enum Tab {
        case home
        case mentors
        case profile
    }
    
    // Body
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            MentorList()
                .tabItem {
                    Label("Mentors", systemImage: "person.2")
                }
                .tag(Tab.mentors)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(Tab.profile)
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        ContentView()
            .environmentObject(mentorData)
    }
}
