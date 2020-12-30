//
//  SettingsInteractor.swift
//  GoGo
//
//  Created by Mathias Erligmann on 17/12/2020.
//

import Foundation

class QuestionInteractor {
    
    var request: QuestionsModels.Request?
    var question: Question?
    var correction: Correction?
    
    let presenter = QuestionPresenter()
    private let worker = QuestionWorker()
    
    func loadQuestion() {
        if let request = request {
            switch request.mode {
            case .correction(let correction):
                self.correction = correction
                self.question = correction.question
                presenter.presentCorrection(question: question!, rightness: correction.rightness)
            case .question(let question):
                self.question = question
                presenter.presentQuestion(question: question)
            }
            presenter.presentTitle(title: request.title)
        }
    }
    
    func handleChoiceSelection(choice: Choice, at indexPath: IndexPath) {
        if let mode = request?.mode {
            switch mode {
            case .correction:
                break
            case .question(let question):
                question.select(choice: choice)
                loadSelectionChanges(question: question, at: indexPath)
                switch question.choices.type {
                case .multiple:
                    break
                case .single:
                    onQuestionEnd()
                }
            }
        }
    }
    
    func loadSelectionChanges(question: Question, at indexPath: IndexPath) {
        switch question.choices.type {
        case .single:
            presenter.presentToggledChoice(for: indexPath)
            presenter.presentCleanedQuestion(toggledIndexPath: indexPath)
        case .multiple:
            presenter.presentToggledChoice(for: indexPath)
        }
    }
    
    func loadPrevious() {
        if let completion = request?.onCompletion {
            presenter.presentPrevious(completion: completion)
        }
    }
    
    func onQuestionEnd() {
        if let question = question {
            switch question.choices.type {
            case .multiple:
                computeRightnessForMultipleChoices()
            case .single:
                break
            }
            checkForNextQuestion()
        }
    }
    
    private func checkForNextQuestion() {
        if let quiz = QuizzWorker.shared.getCurrentQuiz(), let isSkippable = request?.isSkippable {
            switch quiz.loadNextQuestion(isSkippingAllowed: isSkippable) {
            case .yes:
                loadNextQuestion(quiz: quiz)
            case .end:
                let request = SummaryModels.Request(quizz: quiz)
                presenter.presentSummary(request: request)
            case .notAnswered:
                if isSkippable {
                    loadNextQuestion(quiz: quiz)
                } else {
                    let message = Message(title: "Not Answered",
                                          body: "Question must be answered because this question is not skippable", onCompletion: nil, actions: nil)
                    presenter.presentMessage(message: message)
                }
            }
        }
    }
    
    private func loadNextQuestion(quiz: Quiz) {
        let question = quiz.getCurrentQuestion()
        let number = quiz.getCurrentQuestionIndex() + 1
        let request = QuestionsModels.Request(mode: .question(question),
                                              title: "Question \(number)",
                                              isSkippable: quiz.isQuestionSkippable(),
                                              onCompletion: nil)
        presenter.presentNextQuestion(request: request)
    }
    
    private func computeRightnessForMultipleChoices() {
        if let question = question {
            switch question.choices.type {
            case .multiple(let multiples):
                multiples.computeRightness()
            default:
                break
            }
        }
    }
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
