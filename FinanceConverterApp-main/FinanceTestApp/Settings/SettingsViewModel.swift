//
//  SettingsViewModel.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation

class SettingsViewModel {
    
    var router: SettingsRouter
    

    init(router: SettingsRouter) {
        self.router = router
    }
    
    func navigateToPrivacyPolicy() {
        router.routeToPrivacyPolicy()
    }
}
