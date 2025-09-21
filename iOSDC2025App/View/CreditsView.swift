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
    private let scrollDuration: TimeInterval = 10.0

    // クレジット名
    private let names: [String] = [
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
        "よあん"
        "じょにー"
        // add your name
    ]

    @State private var timer: Timer?

    @State private var viewHeight: CGFloat = .zero
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .center, spacing: 8) {
                        Color.clear
                            .frame(height: 1)
                            .id("top")

                        VStack(alignment: .center, spacing: 8) {
                            ForEach(names, id: \.self) { name in
                                Text(name)
                                    .font(.system(size: 22))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.vertical, 4)
                            }
                        }
                        .padding(.bottom, 32)
                        
                        Text("DeNA Engineers")
                            .font(.title)
                            .foregroundStyle(.white)
                        
                        Spacer().frame(height: viewHeight)
                        
                        Color.clear
                            .frame(height: 1)
                            .id("bottom")
                    }
                    .padding()
                }
                .background {
                    Color.black
                        .ignoresSafeArea()
                }
                .onGeometryChange(for: CGFloat.self, of: { proxy in
                    proxy.size.height
                }, action: { newValue in
                    viewHeight = newValue
                })
                .onAppear {
                    proxy.scrollTo("top", anchor: .top)

                    timer?.invalidate()
                    timer = Timer.scheduledTimer(
                        withTimeInterval: scrollDuration,
                        repeats: true
                    ) { _ in
                        withAnimation(.linear(duration: scrollDuration)) {
                            proxy.scrollTo("bottom", anchor: .bottom)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + scrollDuration + 3.0) {
                            withAnimation(nil) {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        }
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton()
                }
                ToolbarItem(placement: .principal) {
                    Text("🎉CONTRIBUTORS🎉")
                        .foregroundStyle(.white)
                        .font(.title2)
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
