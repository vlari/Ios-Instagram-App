//
//  Date+Extension.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import Foundation

extension DateFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
