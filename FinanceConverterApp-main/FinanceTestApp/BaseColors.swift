//
//  BaseColors.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit

class Colors {

    // MARK: - Colors constants

    static let purple = hexStringToUIColor(hex: "#9B51E0", alpha: 1.0)
    static let lightYellow = hexStringToUIColor(hex: "#F2994A", alpha: 1.0)
    static let lightCyan = hexStringToUIColor(hex: "#4CDAE3", alpha: 0.5)
    static let darkGray = hexStringToUIColor(hex: "#000000", alpha: 0.6)
    static let lightGray = hexStringToUIColor(hex: "#D9D9D9", alpha: 0.5)
    static let violet = hexStringToUIColor(hex: "#476CFF", alpha: 1.0)
    static let veryDarkGray = hexStringToUIColor(hex: "#696969", alpha: 1)



    // MARK: - Generate UIColor from hex

    static func hexStringToUIColor (hex: String, alpha: Double = 1.0) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
