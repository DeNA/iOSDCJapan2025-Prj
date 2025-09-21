//
//  File.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import SwiftUI

// ストリートコーディングに参加した皆さんの名前をクレジットとして残すビュー
struct CreditsView: View {
    @Environment(\.dismiss) var dismiss

    // スクロール設定
    private let scrollDuration: TimeInterval = 7 * 10

    // クレジット名
    private static let names: [String] = [
        "armtic",
        "のっちー",
        "Rei",
        "kuroruri",
        "iPodnana",
        "上ちょ",
        "417",
        "Megabits",
        "nnsnodnb",
        "よーしん",
        "aohara",
        "Etsushi",
        "daiki_U",
        "だっちゃん",
        "Tanaka",
        "atsuyan",
        "_tak_hito_",
        "mimimi1204",
        "S_Shimotori",
        "ni_san2000",
        "yamakentoc",
        "tera-ny",
        "noppefoxwolf",
        "tussy5696",
        "いぬしば",
        "スタッフ",
        "tatsubee",
        "こうちゃん",
        "ynoseda",
        "treastrain",
        "ojun",
        "よあん",
        "じょにー",
        "AJ",
        "へじふく"
        // add your name
    ]

    @State private var scrollDirection: ScrollDirection = .top

    @State private var viewHeight: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .center, spacing: 8) {
                        
                        Spacer().frame(height: viewHeight * 0.7)
                        
                        VStack(alignment: .center, spacing: 8) {
                            ForEach((0...9).flatMap { _ in Self.names }, id: \.self) { name in
                                Text(name)
                                    .font(.system(size: 26))
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.vertical, 4)
                                    .padding(.leading, 32)
                            }
                        }
                        .padding(.bottom, 32)
                        
                        Spacer()
                            .frame(height: 1)
                            .id("bottom")
                    }
                    .padding()
                }
                .background {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                }
                .onGeometryChange(for: CGFloat.self, of: { proxy in
                    proxy.size.height + proxy.safeAreaInsets.top
                }, action: { newValue in
                    viewHeight = newValue
                })
                .task {
                    withAnimation(.linear(duration: scrollDuration)) {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
            .scrollDisabled(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton()
                }
                ToolbarItem(placement: .principal) {
                    Text("CONTRIBUTORS")
                        .bold()
                        .foregroundStyle(.white)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .toolbarTitleDisplayMode(.inline)
        }
    }

    private func dismissButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

#Preview {
    CreditsView()
}

enum ScrollDirection {
    case top
    case bottom
}
