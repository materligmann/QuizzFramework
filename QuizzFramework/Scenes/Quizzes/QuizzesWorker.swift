//
//  QuizesWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

class QuizzesWorker {
    
    func makeQuizesSection(loadQuizAction: @escaping (Int) -> Void, quizes: [QuizRef]) -> [FormModels.FormSection] {
        var entries = [FormModels.FormEntry]()
        for quiz in quizes {
            let action = { loadQuizAction(quiz.id) }
            let entry = FormModels.FormEntry(entryType:
                                                .basic(FormModels.BasicEntry(
                                                        titleLocalizedString: quiz.name,
                                                        imageName: .system(quiz.imageName),
                                                        checkMarked: false,
                                                        action: action,
                                                        showDetailIndicator: true)))
            entries.append(entry)
        }
        return [FormModels.FormSection(title: nil, entries: entries)]
    }
    
    func fetchQuiz(path: String,
                   id: Int,
                   completion: @escaping (Result<Quiz, Error>) -> Void) {
        QuizzWorker.shared.fetchQuiz(path: path,
                                     id: id,
                                     completion: completion)
    }
}
