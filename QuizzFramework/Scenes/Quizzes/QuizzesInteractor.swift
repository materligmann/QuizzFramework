//
//  QuizzesInteractor.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

class QuizzesInteractor {
    
    var request: QuizzesModels.Request?
    
    let presenter = QuizzesPresenter()
    private let worker = QuizzesWorker()
    
    func loadQuizzes() {
        if let quizzes = request?.quizzes {
            presenter.presentQuizzes(sections: worker.makeQuizesSection(
                                        loadQuizAction: loadQuiz(id:),
                                        quizes: quizzes))
        }
    }
    
    private func loadQuiz(id: Int) {
        if let category = request?.categoryName {
            worker.fetchQuiz(path: category, id: id) { result in
                switch result {
                case .success(let quiz):
                    QuizzWorker.shared.setCurrentQuizz(quiz: quiz)
                    self.loadQuestion()
                case .failure:
                    break
                }
            }
        }
    }
    
    func loadQuestion() {
        if let quiz = QuizzWorker.shared.getCurrentQuiz() {
            let question = quiz.getCurrentQuestion()
            let title = "Question \(quiz.getCurrentQuestionIndex() + 1)"
            let request = QuestionsModels.Request(mode: .question(question),
                                                  title: title,
                                                  isSkippable: quiz.isQuestionSkippable(), onCompletion: nil)
            presenter.presentQuestion(request: request)
        }
    }
}
