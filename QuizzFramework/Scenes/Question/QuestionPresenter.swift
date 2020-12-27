//
//  SettingsPresenter.swift
//  GoGo
//
//  Created by Mathias Erligmann on 18/12/2020.
//

import Foundation

class QuestionPresenter {
    weak var viewController: QuestionViewController?
    
    func presentSummary(request: SummaryModels.Request) {
        viewController?.navigateToSummary(request: request)
    }
    
    func presentQuestion(question: Question) {
        viewController?.displayQuestion(viewModel:  QuestionsModels.QuestionViewModel(question: question, rightness: nil))
    }
    
    func presentCorrection(question: Question, rightness: Rightness?) {
        viewController?.displayQuestion(viewModel: QuestionsModels.QuestionViewModel(question: question, rightness: rightness))
    }
    
    func presentCleanedQuestion(toggledIndexPath: IndexPath) {
        viewController?.displayCleanedQuestion(toggledIndexPath: toggledIndexPath)
    }
    
    func presentToggledChoice(for toggledIndexPath: IndexPath) {
        viewController?.displayToggledChoice(toggledIndexPath: toggledIndexPath)
    }
    
    func presentNextQuestion(request: QuestionsModels.Request) {
        viewController?.navigateToNextQuestion(request: request)
    }
}
