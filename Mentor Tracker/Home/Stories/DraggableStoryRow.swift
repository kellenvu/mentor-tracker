/*
Referenced https://stackoverflow.com/questions/62606907/swiftui-using-ondrag-and-ondrop-to-reorder-items-within-one-single-lazygrid for drag and drop
*/

import SwiftUI
import UniformTypeIdentifiers

// Story row
struct DraggableStoryRow: View {
    @EnvironmentObject var mentorData: MentorData
    @State private var dragging: Mentor?
    
    // Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.storySpacing) {
                ForEach(mentorData.mentors) { mentor in
                    NavigationLink(destination: MentorProfile(mentor: $mentorData.mentors[mentor])) {
                        StoryCircle(mentor: mentor, size: Constants.imageSize)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .overlay(dragging?.id == mentor.id ? Color.white.opacity(0.8) : Color.clear)
                    .onDrag {
                        self.dragging = mentor
                        return NSItemProvider(object: String(mentor.id) as NSString)
                    }
                    .onDrop(of: [UTType.text], delegate: DragRelocateDelegate(item: mentor, listData: $mentorData.mentors, current: $dragging))
                }
            }
            .animation(.default, value: mentorData.mentors)
        }
        .onDrop(of: [UTType.text], delegate: DropOutsideDelegate(current: $dragging))
    }
    
    // Constants
    struct Constants {
        static let imageSize: CGFloat = 75
        static let storySpacing: CGFloat = 10
    }
}

// Drag relocate delegate
struct DragRelocateDelegate: DropDelegate {
    let item: Mentor
    @Binding var listData: [Mentor]
    @Binding var current: Mentor?

    // Drop entered
    func dropEntered(info: DropInfo) {
        if item != current {
            let from = listData.firstIndex(of: current!)!
            let to = listData.firstIndex(of: item)!
            if listData[to].id != current!.id {
                listData.move(fromOffsets: IndexSet(integer: from),
                    toOffset: to > from ? to + 1 : to)
            }
        }
    }

    // Drop updated
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    // Perform drop
    func performDrop(info: DropInfo) -> Bool {
        self.current = nil
        return true
    }
}

// Drop outside delegate
struct DropOutsideDelegate: DropDelegate {
    @Binding var current: Mentor?
    
    // Perform drop
    func performDrop(info: DropInfo) -> Bool {
        current = nil
        return true
    }
}

// Preview
struct DraggableStoryRow_Previews: PreviewProvider {
    static var mentorData = MentorData(named: "Default")
    
    static var previews: some View {
        DraggableStoryRow()
            .environmentObject(mentorData)
    }
}
