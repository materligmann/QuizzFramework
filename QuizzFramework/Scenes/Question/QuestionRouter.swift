//
//  SettingsRouter.swift
//  GoGo
//
//  Created by Mathias Erligmann on 18/12/2020.
//

import Foundation

class QuestionRouter {
    weak var viewController: QuestionViewController?
    
    func routeToNextQuestion(request: QuestionsModels.Request) {
        let questionViewController = QuestionViewController()
        questionViewController.request = request
        if viewController?.navigationController?.viewControllers.last == viewController {
            viewController?.navigationController?.pushViewController(questionViewController,
                                                                     animated: true)
        }
    }
    
    func routeToSummary(request: SummaryModels.Request) {
        let summaryViewController = SummaryViewController()
        summaryViewController.request = request
        if viewController?.navigationController?.viewControllers.last == viewController {
            viewController?.navigationController?.pushViewController(summaryViewController,
                                                                     animated: true)
        }
    }
}
