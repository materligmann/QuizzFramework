//
//  SummaryInteractor.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation
import StoreKit

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
        let request = QuestionsModels.Request(mode: .correction(correction), title: title, isSkippable: false, onCompletion: requestReview)
        presenter.presentCorrection(request: request)
    }
    
    func requestReview() {
        var count = UserDefaults.standard.integer(forKey: "reviewCount")
        count += 1
        UserDefaults.standard.set(count, forKey: "reviewCount")
        if count < 1 {
            if let scene = UIApplication.shared.windows.first?.windowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
