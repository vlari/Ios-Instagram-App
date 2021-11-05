//
//  String+Extension.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import Foundation

extension String {
    static func date(from date: Date) -> String? {
        let formatter = DateFormatter.formatter
        let string = formatter.string(from: date)
        return string
    }
}
