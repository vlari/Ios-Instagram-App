//
//  Post.swift
//  Instagram
//
//  Created by Obed Garcia on 28/10/21.
//

import Foundation

struct Post: Codable {
    let id: String
    let caption: String
    let postedDate: String
    let postUrlString: String
    var likers: [String]

    var date: Date {
        guard let date = DateFormatter.formatter.date(from: postedDate) else { fatalError() }
        return date
    }

    var storageReference: String? {
        guard let username = UserDefaults.standard.string(forKey: "username") else { return nil }
        return "\(username)/posts/\(id).png"
    }
}
