//
//  FormPresenter.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import Foundation

class FormPresenter {
    weak var viewController: FormViewController?
    
    func presentForm(request: FormModels.Request) {
        viewController?.displayTitle(title: request.formTitleLocalizedString)
        let viewModel = FormModels.ViewModel(sections: request.sections)
        viewController?.displayForm(viewModel: viewModel)
        presentFormAction(action: request.formAction)
        presentCloseButton(presentation: request.presentation)
    }
    
    private func presentFormAction(action: FormModels.FormAction) {
        switch action {
        case .yes(let requirement):
            viewController?.displayActionButtonTitle(title: requirement.actionButtonTitle)
            viewController?.displayActionButtonState(enabled: requirement.isActionButtonEnabled)
        case .no:
            break
        }
    }
    
    func presentCloseButton(presentation: FormModels.FormPresentation) {
        switch presentation {
        case .presented:
            viewController?.displayCloseButton()
        case .pushed:
            break
        }
    }
    
    func dismissForm(completion: (() -> Void)?)  {
        viewController?.navigateToPreviousViewController(completion: completion)
    }
}
