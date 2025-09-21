import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var trackKind: TrackKind = .trackA
    @State private var isCreditViewPresented = false
    
    enum TrackKind: String, CaseIterable, Identifiable {
        case trackA = "Track A"
        case trackB = "Track B"
        case trackC = "Track C"
        case trackD = "Track D"
        
        var id: Int {
            switch self {
            case .trackA: 0
            case .trackB: 1
            case .trackC: 2
            case .trackD: 3
            }
        }
    }
    
    var body: some View {
        TabView {
            ForEach(timetable.days, id: \.id) { day in
                Tab(day.title, systemImage: "\(day.id - 1).circle") {
                    NavigationStack {
                        Picker("", selection: $trackKind) {
                            ForEach(TrackKind.allCases) { kind in
                                Text(kind.rawValue)
                                    .tag(kind)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        daylist(day: day, trackId: trackKind.id)
                    }
                    .searchable(text: $searchText, placement: .navigationBarDrawer)
                }
            }
            Tab(role: .search) {
                searchView()
                    .searchable(text: $searchText, placement: .navigationBarDrawer)
            }
            
            
        }.tabBarMinimizeBehavior(.onScrollUp)
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
    
    // TODO: atsuyan Viewでフィルターしてるの微妙なのでモデルに移したい...
    private func filter(sessions: [iOSDCSession], text: String, trackId: Int?) -> [iOSDCSession] {
        guard !text.isEmpty else {
            return sessions.filter({$0.trackId == trackId})
        }
        return sessions.filter({ $0.title.contains(text) })
    }
    
    @ViewBuilder
    func daylist(day: iOSDCDay, trackId: Int) -> some View {
        List {
            ForEach(filter(sessions: day.sessions, text: searchText, trackId: trackId), id: \.id) { session in
                NavigationLink {
                    // TODO: iOSDCTrack の取得方法ちょっとダサいので任せた
                    DetailView(track: timetable.tracks.track(id: session.trackId), session: session)
                } label: {
                    ContentCell(session: session)
                }
            }
        }
        .navigationTitle("iOSDC Japan 2025 Time Table")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isCreditViewPresented = true
                } label: {
                    Image(systemName: "signature")
                }
            }
        }
        .sheet(isPresented: $isCreditViewPresented) {
            CreditsView()
        }
    }
    
    @ViewBuilder
    func searchView() -> some View {
        NavigationStack {
            List {
                let sessions = timetable.days.compactMap(\.self).flatMap { $0.sessions }
                ForEach(filter(sessions: sessions, text: searchText, trackId: nil), id: \.id) { session in
                    NavigationLink {
                        // TODO: iOSDCTrack の取得方法ちょっとダサいので任せた
                        DetailView(track: timetable.tracks.track(id: session.trackId), session: session)
                    } label: {
                        ContentCell(session: session)
                    }
                }
            }
            .navigationTitle("Search")
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

struct ContentCell: View {
    let session: iOSDCSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 時刻とトラックを表示するヘッダー
            HStack {
                Text(session.startTime, format: .dateTime)
                    .monospacedDigit()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(timetable.tracks[session.trackId].name)
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3).foregroundStyle(.white)
                    .background {
                        if session.trackId == 0 {
                            Color.red
                        } else if session.trackId == 1 {
                            Color.orange
                        } else if session.trackId == 2 {
                            Color.green
                        } else if session.trackId == 3 {
                            Color.blue
                        }
                    }.clipShape(Capsule())
            }
            
            HStack(alignment: .center, spacing: 12) {
                speakerImage(session: session)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(session.title)
                        .bold()
                    // TODO: もっとおしゃれにしてください
                    if let speaker = session.speaker {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(speaker.name)
                        }
                    }
                }
                
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
            .frame(width: 56, height: 56)
            .clipShape(Circle())
        }
    }
}

// MARK: -

extension Array where Element == iOSDCTrack {
    func track(id: Int) -> iOSDCTrack? {
        self.first { $0.id == id }
    }
    
}

