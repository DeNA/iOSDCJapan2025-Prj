//
//  iOSDCSpeaker.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

import Foundation

struct iOSDCSpeaker: Identifiable, Decodable {
    var id: Int
    var name: String
    var imageUrl: URL?
}
