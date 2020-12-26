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
    
    let presenter = QuestionPresenter()
    private let worker = QuestionWorker()
    
    func loadQuestion() {
        if let quizz = request?.quizz {
            self.question = quizz.getCurrentQuestion()
            presenter.presentQuestion(question: question!)
        }
    }
    
    func handleChoiceSelection(choice: Choice, at indexPath: IndexPath) {
        if let question = question {
            question.select(choice: choice)
            loadSelectionChanges(question: question, at: indexPath)
        }
    }
    
    func loadSelectionChanges(question: Question, at indexPath: IndexPath) {
        switch question.choices.type {
        case .single:
            presenter.presentToggledChoice(for: indexPath)
            presenter.presentCleanedQuestion(toggledIndexPath: indexPath)
            loadNextQuestion()
        case .multiple:
            presenter.presentToggledChoice(for: indexPath)
        }
    }
    
    func loadNextQuestion() {
        computeRightnessForMultipleChoices()
        if var quizz = request?.quizz {
            switch quizz.loadNextQuestion() {
            case .yes:
                presenter.presentNextQuestion(request: QuestionsModels.Request(quizz: quizz))
            case .end:
                presenter.presentSummary(request: SummaryModels.Request(quizz: quizz))
            case .notAnswered:
                break
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
