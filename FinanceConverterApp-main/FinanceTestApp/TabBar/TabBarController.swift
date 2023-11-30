//
//  TabBarController.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupTabs() {
        let onboarding = self.createNav(with: "main", image: UIImage(named: "startIcon") ?? UIImage(), viewController: OnboardingViewController())
    }
    
    private func createNav(with title: String, image: UIImage, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        return nav
    }
}
