//
//  OnboardingRouter.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit

class OnboardingModule {
    func createModule() -> UIViewController {
            let viewController = OnboardingViewController()
            viewController.viewModel = OnboardingViewModel(router: OnboardingRouter())
        viewController.viewModel?.router.viewController = viewController
            return viewController
        }
}

class OnboardingRouter {
    weak var viewController: OnboardingViewController?
}

protocol OnboardingRouterProtocol {
    func routeToSettings()
}

extension OnboardingRouter: OnboardingRouterProtocol {
    
    func routeToSettings() {

    }
}
