//
//  SwiftUIView.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import SwiftUI


struct DetailView: View {
    let track: iOSDCTrack?
    let session: iOSDCSession
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                AsyncImage(
                    url: session.speaker?.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(Circle())
                    } placeholder: {
                        Color.gray
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(Circle())
                    }
                
                VStack(spacing: 16) {
                    Text(session.speaker?.name ?? "---")
                        .font(.title2)
                    
                    Text(session.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        Text(session.startTime.yyyyMMdd)
                            .font(.body)
                            .foregroundStyle(Color.gray)
                        
                        Text(track?.name ?? "場外")
                            .font(.body)
                            .foregroundStyle(Color.gray)
                    }
                    
                    Text(session.startTime.time)
                        .font(.body)
                        .foregroundStyle(Color.gray)
                    
                }
                
                Divider()
                
            }
            .padding(.vertical, 40)
        }
    }
}
/**
 var id: Int
 var time: Date
 var title: String
 var trackId: Int
 var duration: Int
 var isSponsor: Bool
 var type: SessionType
 var speaker: iOSDCSpeaker?
 var proposalUrl: URL?

 */

#Preview {
    DetailView(
        track: .init(id: 0, name: "Tack A", hashtag: "#a"),
        session: timetable.days.first!.sessions[1]
    )
}
