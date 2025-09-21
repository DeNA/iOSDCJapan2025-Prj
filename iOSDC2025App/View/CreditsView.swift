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
        "DeNA Engineers"
        // add your name
    ]
    
    private let formatter = ListFormatter()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let formatted = formatter.string(from: names) {
                    Text(formatted)
                        .font(.subheadline.bold())
                        .lineHeight(.loose)
                        .foregroundStyle(.white)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.blue
            }
            .toolbar {
                dismissButton()
            }
            .navigationTitle(Text("🎉CONTRIBUTORS🎉"))
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
