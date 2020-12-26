//
//  UISystem.swift
//  GoGo
//
//  Created by Mathias Erligmann on 07/12/2020.
//

import UIKit

struct UISystem {
    static func getNavigation(rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController()
        navigation.navigationBar.tintColor = .fourthColor
        navigation.viewControllers = [rootViewController]
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
}
