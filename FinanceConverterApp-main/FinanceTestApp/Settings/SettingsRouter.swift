//
//  SettingsRouter.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit
import SafariServices

class SettingsModule {
    func createModule() -> UIViewController {
            let viewController = SettingsViewController()
        viewController.viewModel = SettingsViewModel(router: SettingsRouter())
        viewController.viewModel?.router.viewController = viewController
            return viewController
        }
}

class SettingsRouter {
    weak var viewController: SettingsViewController?
}

protocol SettingsRouterProtocol {
    func routeToSettings()
    func routeToPrivacyPolicy()
}

extension SettingsRouter: SettingsRouterProtocol {
    func routeToSettings() {
    }
    func routeToPrivacyPolicy() {
        guard let url = URL(string: "https://www.twitch.tv/melharucos") else {
                    return
                }
        let safariVC = SFSafariViewController(url: url)
        viewController?.present(safariVC, animated: true, completion: nil)
    }
}
