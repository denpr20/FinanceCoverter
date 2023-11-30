//
//  CalculatorModule.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit
import SafariServices

class CalculatorModule {
    func createModule() -> UIViewController {
            let viewController = CalculatorViewController()
        viewController.viewModel = CalculatorViewModel(router: CalculatorRouter())
        viewController.viewModel?.router.viewController = viewController
            return viewController
        }
}

class CalculatorRouter {
    weak var viewController: CalculatorViewController?
}

protocol CalculatorRouterProtocol {
    func routeToSettings()
    func routeToPrivacyPolicy()
}

extension CalculatorRouter: CalculatorRouterProtocol {
    func routeToSettings() {
        print("Hi!")
    }
    func routeToPrivacyPolicy() {
        guard let url = URL(string: "https://www.twitch.tv/melharucos") else {
                    // We should handle an invalid stringURL
                    return
                }

                // Present SFSafariViewController
        let safariVC = SFSafariViewController(url: url)
        viewController?.present(safariVC, animated: true, completion: nil)
    }
}
