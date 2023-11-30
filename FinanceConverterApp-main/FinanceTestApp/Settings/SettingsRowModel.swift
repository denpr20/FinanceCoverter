//
//  SettingsRowModel.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit

struct SettingsRowModel {
    let name: String
    let icon: UIImage
    let tag: SettingsTag
    
}

enum SettingsTag {
    case rating
    case privacyPolicy
    case contact
    case share
}
