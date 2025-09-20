//
//  Day.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

import Foundation

struct iOSDCDay: Identifiable, Decodable {
    let id: Int
    /// This day's name to display on view
    let title: String
    let date: Date
    let sessions: [iOSDCSession]
}
