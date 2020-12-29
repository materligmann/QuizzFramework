//
//  MainRouter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class CategoriesRouter {
    weak var viewController: CategoriesViewController?
    
    func routeToQuizzes(request: QuizzesModels.Request) {
        let quizzesViewController = QuizzesViewController()
        quizzesViewController.request = request
        viewController?.navigationController?.pushViewController(quizzesViewController,
                                                                 animated: true)
    }
}
