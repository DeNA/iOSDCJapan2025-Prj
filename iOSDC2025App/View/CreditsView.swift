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
        // add your name
    ]
    
    private let formatter = ListFormatter()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("🎉CONTRIBUTORS🎉")
                        .font(Font.largeTitle.bold())
                    
                    // TODO: 可愛く派手にしてくださいーーー！！！！
                    if let formatted = formatter.string(from: names) {
                        Text(formatted)
                            .font(.subheadline.bold())
                    }
                }
                .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.pink
                    .ignoresSafeArea()
            }
            .toolbar {
                dismissButton()
            }
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
