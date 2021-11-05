//
//  StoriesViewModel.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import Foundation
import UIKit

struct StoriesViewModel {
    let stories: [Story]
}

struct Story {
    let username: String
    let image: UIImage?
}
