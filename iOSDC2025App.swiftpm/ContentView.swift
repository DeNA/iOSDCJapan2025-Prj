import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(timetable.days, id: \.id) { day in
                Section {
                    Text("TBD")
                } header: {
                    Text(day.title)
                }
            }
        }
    }
}

let timetable: Timetable = {
    let url = Bundle.main.url(forResource: "iosdc2025_timetable", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try! decoder.decode(Timetable.self, from: data)
}()

struct Timetable: Codable {
    let days: [Day]
}

struct Day: Codable {
    let id: Int
    let title: String
    let sessions: [Session]
}

struct Session: Codable {
    let id: Int
    let title: String
    let trackId: Int
}
