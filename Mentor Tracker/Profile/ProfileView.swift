import SwiftUI

// Profile View
struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Settings")
                    Text("Archive")
                    Text("Your Activity")
                }
                Section {
                    Text("Notifications")
                    Text("Privacy")
                    Text("Account")
                    Text("Help")
                    Text("About")
                }
                Section {
                    Text("Log Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    settingsButton
                }
            }
        }
    }
    
    // Settings button
    private var settingsButton: some View {
        Button {
        } label: {
            Image(systemName: "gearshape.fill")
        }
    }
}

// Preview
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
