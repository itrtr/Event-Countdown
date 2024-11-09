import SwiftUI

struct EventsView: View {
    @Binding var events: [Event]
    
    var body: some View {
        NavigationStack {
            List(events.sorted()) { event in
                NavigationLink(value: event) {
                    EventRow(event: event)
                        .swipeActions {
                            Button(role: .destructive) {
                                if let index = events.firstIndex(where: { $0.id == event.id }) {
                                    events.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "trash").font(.title3)
                            }
                        }
                }
            }
            .navigationDestination(for: Event.self) { event in
                if let index = events.firstIndex(where: { $0.id == event.id }) {
                    EventForm(events: $events, action: .update(index: index))
                }

            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        EventForm(events: $events, action: .add)
                    } label: { Image(systemName: "plus").font(.title3) }
                }
            }
        }
    }
}
