//
//  MainPresenter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class MainPresenter {
    weak var viewController: MainViewController?
    
    func presentQuizzes(sections: [FormModels.FormSection]) {
        viewController?.displayQuizzes(viewModel:
                                        FormModels.ViewModel(sections: sections))
    }
    
    func presentQuestion(request: QuestionsModels.Request) {
        viewController?.navigateToQuestion(request: request)
    }
}
