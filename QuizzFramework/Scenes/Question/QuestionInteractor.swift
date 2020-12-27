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
        if let mode = request?.mode {
            switch mode {
            case .correction(let correction):
                self.correction = correction
                self.question = correction.question
                presenter.presentCorrection(question: question!, rightness: correction.rightness)
            case .question(let question):
                self.question = question
                presenter.presentQuestion(question: question)
            }
            
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
                onQuestionEnd()
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
    
    func onQuestionEnd() {
        loadNextQuestion()
    }
    
    private func loadNextQuestion() {
        computeRightnessForMultipleChoices()
        if let quizz = QuizzWorker.shared.getCurrentQuizz() {
            switch quizz.loadNextQuestion() {
            case .yes:
                presenter.presentNextQuestion(request: QuestionsModels.Request(mode: .question(quizz.getCurrentQuestion())))
            case .end:
                presenter.presentSummary(request: SummaryModels.Request(quizz: quizz))
            case .notAnswered:
                break //TODO: Implement
            }
        }
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
