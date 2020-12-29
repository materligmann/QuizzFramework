//
//  MainWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class CategoriesWorker {
    func fetchQuizCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        QuizzWorker.shared.getCategoriesFromServer { categories in
            if let categories = categories {
                completion(.success(categories))
            } else {
                completion(.failure(FetchError.noCategories))
            }
        }
    }
    
    func makeCategoriesSections(quizesAction: @escaping (Category) -> Void, categories: [Category]) -> [FormModels.FormSection] {
        var entries = [FormModels.FormEntry]()
        for category in categories {
            let action = { quizesAction(category) }
            let entry = FormModels.FormEntry(entryType: .basic(FormModels.BasicEntry(
                                                                titleLocalizedString: category.title,
                                                                imageName: .system(category.imageName),
                                                                checkMarked: false,
                                                                action: action,
                                                                showDetailIndicator: true)))
            entries.append(entry)
        }
        return [FormModels.FormSection(title: nil, entries: entries)]
    }
}

enum FetchError: Error {
    case noCategories
}
