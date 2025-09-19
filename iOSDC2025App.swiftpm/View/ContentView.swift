import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(timetable.days, id: \.id) { day in
                    List {
                        Section {
                            Button(action: {
                            }) {
                                Text("TBD")
                            }
                        } header: {
                            Text(day.title)
                        }
                    }
                    .tabItem {
                        Label(day.title, systemImage: "\(day.id - 1).circle")
                    }
                }
            }
            .navigationTitle("iOSDC Time Table")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: - TBD
                    } label: {
                        Image(systemName: "menucard")
                    }
                }
            }
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
