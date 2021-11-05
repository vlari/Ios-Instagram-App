//
//  SettingsModels.swift
//  Instagram
//
//  Created by Obed Garcia on 3/11/21.
//

import Foundation
import UIKit

struct SettingsSection {
    let title: String
    let options: [SettingOption]
}

struct SettingOption {
    let title: String
    let image: UIImage?
    let color: UIColor
    let handler: (() -> Void)
}

