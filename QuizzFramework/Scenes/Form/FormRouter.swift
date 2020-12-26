//
//  FormRouter.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import Foundation

class FormRouter {
    weak var viewController: FormViewController?
    
    func routeToPreviousViewController(completion: (() -> Void)?) {
        if viewController?.navigationController?.presentingViewController == nil {
            viewController?.navigationController?.popViewController(animated: true, completion: completion)
        } else {
            viewController?.navigationController?.dismiss(animated: true, completion: completion)
        }
    }
}
