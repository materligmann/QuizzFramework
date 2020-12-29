//
//  QuizzesPresenter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

class QuizzesPresenter {
    weak var viewController: QuizzesViewController?
    
    func presentQuizzes(sections: [FormModels.FormSection]) {
        viewController?.displayForm(viewModel: FormModels.ViewModel(sections: sections))
    }
    
    func presentQuestion(request: QuestionsModels.Request) {
        viewController?.navigateToQuestion(request: request)
    }
}
