//
//  ExchangeRateResponse.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 06.11.2023.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}
