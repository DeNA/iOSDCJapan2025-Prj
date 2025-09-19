//
//  iOSDCSession.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

import Foundation

struct iOSDCSession: Identifiable, Decodable {
    var id: Int
    var time: Date
    var title: String
    var trackId: Int
    var duration: Int
    var isSponsor: Bool
    var type: String
    var speaker: iOSDCSpeaker?
    var proposalUrl: URL?
}
