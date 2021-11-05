//
//  Notification.swift
//  Instagram
//
//  Created by Obed Garcia on 28/10/21.
//

import Foundation

struct IGNotification: Codable {
    let identifer: String
    let notificationType: Int // 1: like, 2: comment, 3: follow
    let profilePictureUrl: String
    let username: String
    let dateString: String
    // Follow/Unfollow
    let isFollowing: Bool?
    // Like/Comment
    let postId: String?
    let postUrl: String?
}
