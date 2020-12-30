//
//  SummaryRouter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 26/12/2020.
//

import Foundation


class SummaryRouter {
    weak var viewController: SummaryViewController?
    
    func routeToCorrection(request: QuestionsModels.Request) {
        let questionViewController = QuestionViewController()
        questionViewController.request = request
        if viewController?.navigationController?.viewControllers.last == viewController {
            viewController?.navigationController?.pushViewController(questionViewController,
                                                                     animated: true)
        }
    }
}
