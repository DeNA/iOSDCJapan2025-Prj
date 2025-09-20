//
//  iOSDCAppShortcutsProvider.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import AppIntents

struct iOSDCAppShortcutsProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: TimetableAppIntents(),
            phrases: [
                "timetable \(.applicationName)"
            ],
            shortTitle: "timetable",
            systemImageName: "swift"
        )
    }
}
