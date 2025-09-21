//
//  SwiftUIView.swift
//  iOSDC2025App
//
//  Created by @mimimi1204 on 2025/09/20.
//

import SwiftUI
import FoundationModels

struct DetailView: View {
    let track: iOSDCTrack?
    let session: iOSDCSession
    @State var counter : Int = 0
    @State var flag : Bool = false
    @State var summary: String? = nil
    @State private var isGenerating = false
    @State private var generationError: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                AsyncImage(
                    url: session.speaker?.imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: flag ? 300 : 200)
                            .clipShape(Circle())
                            .animation(.linear, value: flag)
                    } placeholder: {
                        Color.gray
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(Circle())
                    }
                
                VStack(spacing: 16) {
                    Text(session.speaker?.name ?? "---")
                        .font(.title2)
                        .foregroundStyle(Color.black)
                        .onTapGesture {
                            counter += 1
                            
                            if counter.isMultiple(of: 10) {
                                flag.toggle()
                            }
                        }
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
            
            VStack(spacing: 10) {
                // TODO: generatingボタンと概要テキスト間のスペースが気になる
                if !isGenerating, generationError == nil {
                    GenerateSummaryButton(action: generateSummary)
                }
                
                if isGenerating {
                    ProgressView("想像中💭")
                }

                if let generationError {
                    Text("生成に失敗しました: \(generationError)")
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                if
                    let summary,
                    !isGenerating
                {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("概要")
                            .font(.headline)
                        Text(summary)
                            .font(.body)
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }

            }
            .padding(.vertical, 40)
        }
    }
}

private extension DetailView {
    func generateSummary() {
        Task {
            isGenerating = true
            generationError = nil
            do {
                // Use Foundation Models to imagine a session summary from the title
                let instructions =  "次のセッションタイトルから、参加者が内容を把握できる日本語の短い概要(2-3文)を作成してください"
                let session = LanguageModelSession(instructions: instructions)
                _ = SystemLanguageModel.default
                let output = try await session.respond(to: self.session.title)
                // Keep it concise
                summary = output.content
            } catch {
                generationError = error.localizedDescription
            }
            isGenerating = false
        }
    }
}


private struct GenerateSummaryButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("トークの内容を想像する")
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

