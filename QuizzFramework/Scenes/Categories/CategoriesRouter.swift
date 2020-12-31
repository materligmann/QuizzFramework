//
//  MainRouter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import UIKit

class CategoriesRouter {
    weak var viewController: CategoriesViewController?
    
    func routeToQuizzes(request: QuizzesModels.Request) {
        let quizzesViewController = QuizzesViewController()
        quizzesViewController.request = request
        if viewController?.navigationController?.viewControllers.last == viewController {
            viewController?.navigationController?.pushViewController(quizzesViewController,
                                                                     animated: true)
        }
    }
    
    func routeToNewQuiz() {
        let newQuizViewController = UIViewController()
        if viewController?.navigationController?.viewControllers.last == viewController {
            viewController?.present(newQuizViewController, animated: true)
        }
    }
}
