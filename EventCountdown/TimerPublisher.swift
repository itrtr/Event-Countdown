import SwiftUI

struct TimerPublisher: View {
    @State private var time = Date.now
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(time)").onReceive(timer) { input in
            time = input
        }
    }
}

#Preview {
    TimerPublisher()
}
