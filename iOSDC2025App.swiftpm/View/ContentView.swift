import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(timetable.days, id: \.id) { day in
                    List {
                        ForEach(day.sessions, id: \.id) { session in
                            Button(action: {
                            }) {
                                VStack(alignment: .leading) {
                                    Text(session.time.dateString)
                                    Text(session.title)
                                        .font(.title)
                                    // TODO: もっとおしゃれにしてください
                                }
                            }
                            .buttonStyle(.plain)
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

#Preview {
    ContentView()
}

extension Date {
    var dateString: String {
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: self)
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
