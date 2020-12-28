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
        if let request = request {
            presenter.presentSummary(sections:
                                        worker.getSummarySections(
                                            quizz: request.quizz,
                                            onQuestionDetailRequest: loadQuestionDetail))
        }
    }
    
    func loadQuestionDetail(correction: Correction, title: String) {
        let request = QuestionsModels.Request(mode: .correction(correction), title: title, isSkippable: false)
        presenter.presentCorrection(request: request)
    }
}
