import Foundation
import SwiftUI

struct Event : Hashable, Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    var color: Color
}

extension Event: Comparable {
    static func < (lhs: Event, rhs: Event) -> Bool {
        return lhs.date < rhs.date
    }
}
