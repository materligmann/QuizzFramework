//
//  MainRouter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class MainRouter {
    weak var viewController: MainViewController?
    
    func routeToQuestion(request: QuestionsModels.Request) {
        let questionViewController = QuestionViewController()
        questionViewController.request = request
        viewController?.navigationController?.pushViewController(questionViewController,
                                                                 animated: true)
    }
}
