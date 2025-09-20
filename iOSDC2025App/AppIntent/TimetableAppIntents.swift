//
//  TimetableAppIntents.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import AppIntents

struct TimetableAppIntents: AppIntent {
    static var title: LocalizedStringResource {
        "timetable app intents"
    }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let sessions = await timetable.days.map(\.sessions)
        let sessionTitles = sessions.map {
            let title = $0.map(\.title)
            return title.joined(separator: ",")
        }
        
        return .result(value: sessionTitles.joined(separator: "\n"))
    }
}
