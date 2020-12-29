//
//  MainInteractor.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class CategoriesInteractor {
    var request: CategoriesModels.Request?
    
    let presenter = CategoriesPresenter()
    private let worker = CategoriesWorker()
    
    func loadCategories() {
        worker.fetchQuizCategories() { result in
            switch result {
            case .success(let categories):
                let sections = self.worker.makeCategoriesSections(quizesAction: self.loadQuizzes, categories: categories)
                self.presenter.presentCategories(sections: sections)
            case .failure:
                break
            }
        }
    }
    
    func loadQuizzes(category: Category) {
        let request = QuizzesModels.Request(quizzes: category.quizes,
                                            categoryName: category.name)
        presenter.presentQuizes(request: request)
    }
}
