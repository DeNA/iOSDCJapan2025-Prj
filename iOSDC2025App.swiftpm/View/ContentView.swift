import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ForEach(timetable.days, id: \.id) { day in
                    List {
                        ForEach(day.sessions, id: \.id) { session in
                            NavigationLink {
                                // TODO: iOSDCTrack の取得方法ちょっとダサいので任せた
                                DetailView(track: timetable.tracks.track(id: session.trackId), session: session)
                            } label: {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Text(session.startTime.dateString)
                                            Text(timetable.tracks[session.trackId].name)
                                        }
                                        Text(session.title)
                                            .font(.title)
                                        // TODO: もっとおしゃれにしてください
                                        if let speaker = session.speaker {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(speaker.name)
                                            }
                                        }
                                    }
                                    .padding(4)
                                    Spacer()
                                    speakerImage(session: session)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
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
    
    @ViewBuilder
    func speakerImage(session: iOSDCSession) -> some View {
        if let imageUrl = session.speaker?.imageUrl {
            AsyncImage(
                url: imageUrl,
                content: { image in
                    image.image?.resizable()
                }
            )
            .frame(width: 60, height: 60)
            .clipShape(Circle())
        }
    }
}

#Preview {
    ContentView()
}

let timetable: IOSDC2025Timetable = {
    let url = Bundle.main.url(forResource: "iosdc2025_timetable", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    return try! decoder.decode(IOSDC2025Timetable.self, from: data)
}()



// MARK: -

extension Array where Element == iOSDCTrack {
    func track(id: Int) -> iOSDCTrack? {
        self.first { $0.id == id }
    }
    
}
