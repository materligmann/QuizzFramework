//
//  SummaryInteractor.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class SummaryInteractor {
    
    var request: SummaryModels.Request?
    
    let presenter = SummaryPresenter()
    private let worker = SummaryWorker()
    
    func loadSummary() {
        if let quizz = request?.quizz {
            presenter.presentSummary(sections: worker.getSummarySections(quizz: quizz,
                                                                         onQuestionDetailRequest: loadQuestionDetail))
        }
    }
    
    func loadQuestionDetail(correction: Correction) {
        let request = QuestionsModels.Request(mode: .correction(correction))
        presenter.presentCorrection(request: request)
    }
}
