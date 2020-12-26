//
//  MainInteractor.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class MainInteractor {
    var request: MainModels.Request?
    
    let presenter = MainPresenter()
    private let worker = MainWorker()
    
    func loadQuizzes() {
        let sections = worker.getQuizzesSections(ethQuizzAction: loadEthQuizz)
        presenter.presentQuizzes(sections: sections)
    }
    
    func loadEthQuizz() {
        QuizzWorker.shared.getQuizzFromServer { quizz in
            if let quizz = quizz {
                let request = QuestionsModels.Request(quizz: quizz)
                self.presenter.presentQuestion(request: request)
            }
        }
    }
}
