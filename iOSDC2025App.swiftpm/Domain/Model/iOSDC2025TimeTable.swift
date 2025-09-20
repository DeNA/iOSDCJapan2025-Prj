//
//  iOSDC2025TimeTable.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/19.
//

// Resources/iosdc2025_timetable.json

struct IOSDC2025Timetable:  Decodable {
    let tracks: [iOSDCTrack]
    let days: [iOSDCDay]
}
