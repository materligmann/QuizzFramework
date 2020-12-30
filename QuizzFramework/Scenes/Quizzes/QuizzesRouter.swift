//
//  QuizzesRouter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

class QuizzesRouter {
    weak var viewController: QuizzesViewController?
    
    func routeToQuestion(request: QuestionsModels.Request) {
        let questionViewController = QuestionViewController()
        questionViewController.request = request
        let questionNavigation = UISystem.getNavigation(rootViewController: questionViewController)
        if viewController?.navigationController?.presentedViewController == nil {
            questionViewController.navigationItem.largeTitleDisplayMode = .always
            questionNavigation.isModalInPresentation = true
            viewController?.navigationController?.present(questionNavigation, animated: true)
        }
    }
}
