//
//  CategoriesPresenter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

class CategoriesPresenter {
    weak var viewController: CategoriesViewController?
    
    func presentCategories(sections: [FormModels.FormSection]) {
        viewController?.displayCategories(viewModel: FormModels.ViewModel(sections: sections))
    }
    
    func presentQuizes(request: QuizzesModels.Request) {
        viewController?.navigateToQuizzes(request: request)
    }
}
