import SwiftUI

struct EventFormErrorView: View {
    var errorMessage: String
    var body: some View {
        HStack {
            Spacer()
            Text(errorMessage)
                .foregroundStyle(.red)
                .font(.caption)
                .bold()
            Spacer() }
    }
}

struct EventForm: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var errorMessage: String = ""
    @State private var date: Date = Date.now
    @State private var color: Color = .black
    @Binding var events: [Event]
    var action: EventAction
    var onSave: (Event) -> Void
    
    var body: some View {
        Form {
            if !errorMessage.isEmpty { EventFormErrorView(errorMessage: errorMessage) }
            TextField("Title", text: $title)
                .padding(.vertical, 2)
                .foregroundColor(color)
                .onAppear { if case .update(let index) = action { title = events[index].title } }
                .onChange(of: title) {errorMessage = ""}
            DatePicker("Date", selection: $date)
                .padding(.vertical, 2)
                .onAppear { if case .update(let index) = action { date = events[index].date } }
            ColorPicker("Text Color", selection: $color)
                .padding(.vertical, 2)
                .onAppear { if case .update(let index) = action { color = events[index].color } }
        }
        .navigationTitle(getHeaderTitle(action, events))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if !title.isEmpty {
                        onSave(Event(title: title, date: date, color: color))
                        dismiss()
                    } else {
                        errorMessage = "Title is empty!"
                    }
                } label: {
                    Image(systemName: "checkmark")
                        .font(.title3)
                }
            }
        }
    }
    
    // Generate header title based on whether we're on add or update mode. If on update mode, shrink the title
    // to some reasonable value
    private func getHeaderTitle(_ action: EventAction, _ events: [Event]) -> String {
        var headerTitle = "Add Event"
        if case .update(let index) = action {
            headerTitle = "Edit " + events[index].title
            if headerTitle.count >= 18 {
                headerTitle = headerTitle.prefix(18) + "..."
            }
        }
        return headerTitle
    }
    
    // validates the index
    private func validIndex(_ index: Int, _ events: [Event]) -> Bool {
        index >= 0 && index < events.count
    }
}
