import SwiftUI

struct ContentView: View {
    @State var events: [Event] = []
    var body: some View {
        EventsView(events: $events)
    }
}

#Preview {
    ContentView(events: [
        Event(title: "First Event", date: Date(), color: .brown),
        Event(title: "Second Event is Largest", date: Date(), color: .red),
        Event(title: "Third Event", date: Date(), color: .blue)
    ])
}
