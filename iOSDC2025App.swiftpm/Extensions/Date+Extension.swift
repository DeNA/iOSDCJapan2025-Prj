//
//  Date+Extension.swift
//  iOSDC2025App
//
//  Created by iosdc-dena on 2025/09/20.
//

import Foundation

extension Date {
    @available(*, deprecated, message: "Use the FormatStyle.")
    var dateString: String {
        let formatter = formatter(format: "yyyy/MM/dd HH:mm:ss")
        return formatter.string(from: self)
    }
    
    var yyyyMMdd: String {
        let formatter = formatter(format: "yyyy/MM/dd")
        return formatter.string(from: self)
    }
    
    var time: String {
        let formatter = formatter(format: "HH:mm:ss")
        return formatter.string(from: self)
    }
    
    func formatter(format: String) -> DateFormatter {
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.dateFormat = format
        return formatter

    }
    
    
}
