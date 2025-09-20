//
//  iOSDCSession.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

import Foundation

struct iOSDCSession: Identifiable, Decodable {
    var id: Int
    var startTime: Date
    var title: String
    var trackId: Int
    var duration: Int
    var isSponsor: Bool
    var type: SessionType
    var speaker: iOSDCSpeaker?
    var proposalUrl: URL?
}

extension iOSDCSession {
    enum SessionType: String, Decodable {
        case normal
        case other
        case qa
        case lt
    }
}
