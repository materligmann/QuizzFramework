//
//  UIViewController+Alert.swift
//  GoGo
//
//  Created by Mathias Erligmann on 28/11/2020.
//

import UIKit

extension UIViewController {
    func displayMessage(message: Message) {
        let alert = UIAlertController(title: message.title,
                                      message: message.body,
                                      preferredStyle: .alert)
        if let actions = message.actions, !actions.isEmpty {
            for action in actions {
                let action = UIAlertAction(title: action.actionTitle,
                                           style: action.style.associatedAlertActionStyle) { _ in
                    action.onCompletion?()
                }
                alert.addAction(action)
            }
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                message.onCompletion?()
            }
            alert.addAction(okAction)
        }
        present(alert, animated: true)
    }
}
