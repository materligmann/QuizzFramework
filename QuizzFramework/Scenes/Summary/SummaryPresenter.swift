//
//  SummaryPresenter.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class SummaryPresenter {
    weak var viewController: SummaryViewController?
    
    func presentSummary(sections: [FormModels.FormSection]) {
        viewController?.displaySummary(viewModel: FormModels.ViewModel(sections: sections))
    }
}
