//
//  Date+Extension.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import Foundation

extension Date {
    var dateString: String {
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: self)
    }
}
