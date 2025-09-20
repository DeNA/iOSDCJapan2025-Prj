//
//  SwiftUIView.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import SwiftUI

struct DetailView: View {
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
                    
                    Text(session.time.dateString)
                        .font(.body)
                        .foregroundStyle(Color.gray)
                }
            }
            .padding(.vertical, 40)
        }
    }
}

#Preview {
    DetailView(session: timetable.days.first!.sessions[1])
}
