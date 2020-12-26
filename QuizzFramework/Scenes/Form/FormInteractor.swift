//
//  FormInteractor.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import Foundation

class FormInteractor {
    
    var request: FormModels.Request?
    
    var presenter = FormPresenter()
    
    func loadForm() {
        if let request = request {
            presenter.presentForm(request: request)
        }
    }
    
    func closeForm() {
        if let onFormCloseAction = request?.onFormClose {
            onFormCloseAction()
        } else {
            presenter.dismissForm(completion: nil)
        }
    }
    
    func saveForm(formController: FormViewController) {
        switch request?.formAction {
        case .yes(let requirement):
            requirement.onAction(formController)
        case .no:
            break
        case .none:
            break
        }
    }
}
