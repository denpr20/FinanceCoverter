//
//  CalculatorViewModel.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation

class CalculatorViewModel {
    
    var router: CalculatorRouter
    var available = ["AED", "EUR", "GEL", "RUB", "USD", "LIR", "GBP"]
    
    
    init(router: CalculatorRouter) {
        self.router = router
    }
    
    func getRatesBasedOnCurrency(current:  String) -> [String: Double] {
        if let url = Bundle.main.url(forResource: "Currencies", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(ExchangeRateResponse.self, from: data)
                    var val1 = 0
                    var val2 = 0
                    
                } catch {
                    print("error:\(error)")
                }
            }
        return ["" : 0]
    }

    func convertValues(firstValue: String, secondValue: String, enteredNumber: Int) -> Double {
        var name1 = "GBP"
        var name2 = "GBP"
        switch firstValue {
        case "Фунт £":
            name1 = "GBP"
        case "Лира ₺":
            name1 = "TRY"
        case "Евро €":
            name1 = "EUR"
        case "Лари ₾":
            name1 = "GEL"
        case "Рубль ₽":
            name1 = "RUB"
        case "Дирхам د.إ":
            name1 = "AED"
        case "Доллар $":
            name1 = "USD"
        default:
            name1 = "GBP"
        }
        switch secondValue {
        case "Фунт £":
            name2 = "GBP"
        case "Лира ₺":
            name2 = "TRY"
        case "Евро €":
            name2 = "EUR"
        case "Лари ₾":
            name2 = "GEL"
        case "Рубль ₽":
            name2 = "RUB"
        case "Дирхам د.إ":
            name2 = "AED"
        case "Доллар $":
            name2 = "USD"
        default:
            name2 = "GBP"
        }
        do {
            var rate = PersistenceService.shared.loadExchangeRateData()[0]
                var val1 = 0.0
                var val2 = 0.0
                for currency in rate.rates {
                    if currency.key == name1 {
                        val1 = currency.value
                    }
                    if currency.key == name2 {
                        val2 = currency.value
                    }
                }
            return ((val2 / val1) * 1000).rounded() / 1000
           
        } catch {
        }
    }
    
    func navigateToPrivacyPolicy() {
        router.routeToPrivacyPolicy()
    }
}
