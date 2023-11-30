//
//  TabBarRoutr.swift
//  FinanceTestApp
//
//  Created by Marat Giniyatov on 02.11.2023.
//

import Foundation
import UIKit

class TabBarRouter {
    
    // MARK: - Coordinators variables
    
    lazy var rootViewController = UITabBarController()
    lazy var onboardingModule = OnboardingModule()
    lazy var calculatorModule = CalculatorModule()
    lazy var settingsModule = SettingsModule()

    // MARK: - Routes
    
    enum  Route {
        case onboarding
        case calculator
        case settings
    }
    
    // MARK: - Navigation method
    
    func navigate(with route: Route) {
        switch route {
        case .onboarding:
            rootViewController.selectedIndex = 0
        case .calculator:
            rootViewController.selectedIndex = 1
        case .settings:
            rootViewController.selectedIndex = 2
        }
    }
    
    // MARK: - TabBar configuration
    
    func configureModule() -> UIViewController {
        let onboardingController = UINavigationController(rootViewController: onboardingModule.createModule())
        let onboardingTabImage = UIImage(systemName: "house")
        let onboardingTabTitle = "Курсы"
        
        onboardingController.tabBarItem = UITabBarItem(title: onboardingTabTitle, image: onboardingTabImage, tag: 0)

        let calculatorController = UINavigationController(rootViewController: calculatorModule.createModule())
        let calculatorTabImage = UIImage(named: "Settings")
        let calculatorTabTitle = "Конвертер валют"
        
        calculatorController.tabBarItem = UITabBarItem(title: calculatorTabTitle, image: calculatorTabImage, tag: 1)
        
        let settingsController = UINavigationController(rootViewController: settingsModule.createModule())
        let settingsTabImage = UIImage(systemName: "gear")
        let settingsTabTitle = "Настройки"
        
        settingsController.tabBarItem = UITabBarItem(title: settingsTabTitle, image: settingsTabImage, tag: 2)
        
        
    
        rootViewController.viewControllers = [onboardingController, calculatorController, settingsController]
        return rootViewController
    }
}
