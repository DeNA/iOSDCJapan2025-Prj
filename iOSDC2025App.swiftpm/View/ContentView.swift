import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(timetable.days, id: \.id) { day in
                    Section {
                        Button(action: {                            
                        }) {
                            Text("TBD")
                        }
                    } header: {
                        Text(day.title)
                    }
                }
            }
            .navigationTitle("iOSDC Time Table")
        }
    }
}

let timetable: IOSDC2025Timetable = {
    let url = Bundle.main.url(forResource: "iosdc2025_timetable", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    return try! decoder.decode(IOSDC2025Timetable.self, from: data)
}()
