//
//  Day.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

import Foundation

struct iOSDCDay: Identifiable, Decodable {
    let id: Int
    // TODO: S_Shimotori
    /// The human-readable title e.g. "Day 0".
    let title: String
    let date: Date
    let sessions: [iOSDCSession]
}
