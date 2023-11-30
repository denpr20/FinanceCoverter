//
//  OnboardingViewModel.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import Combine
import UIKit

class OnboardingViewModel {
    
    var router: OnboardingRouter
    

    init(router: OnboardingRouter) {
        self.router = router
    }
    
    func navigateToSettings() {
        router.routeToSettings()
    }
    
    func convertValues(firstValue: String, secondValue: String) -> Double {
        do {
            print(PersistenceService.shared.loadExchangeRateData())
            var rate = PersistenceService.shared.loadExchangeRateData()[0]
                var val1 = 0.0
                var val2 = 0.0
                for currency in rate.rates {
                    if currency.key == firstValue {
                        val1 = currency.value
                    }
                    if currency.key == secondValue {
                        val2 = currency.value
                    }
                }
            return ((val2 / val1) * 1000).rounded() / 1000
           
        } catch {
            print("error:")
        }
        
        return 0
        
    }
    
//    func fetchChats() -> [ChatEntity] {
//        let chats = PersistenceService.shared.fetchChats()
//        return chats
//    }
//    func addNewChat() {
//        let chat = ChatEntity(name: "SomeNewChat", id: PersistenceService.shared.getChatID() + 1)
//        PersistenceService.shared.saveChat(chat: chat)
//    }
//    func startFirstChat() {
//        let chat = ChatEntity(name: "Theme", id: 0)
//        PersistenceService.shared.saveFirstChat(chat: chat)
//
//    }
}
