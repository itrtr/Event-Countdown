import SwiftUI

struct EventRow: View {
    @State var currentDate = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let formatter = RelativeDateTimeFormatter()
    var event: Event
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title).foregroundColor(event.color)
                .bold()
                .padding(.zero)
            Text(formatter.localizedString(for: event.date, relativeTo: currentDate))
                .padding(.zero)
                .onReceive(timer) { _ in
                currentDate = Date.now
            }
        }
    }
}

#Preview {
    EventRow(event:Event(title: "First Event", date: Date(), color: .brown))
}
