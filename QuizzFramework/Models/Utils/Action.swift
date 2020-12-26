//
//  Action.swift
//  GoGo
//
//  Created by Mathias Erligmann on 01/12/2020.
//

import UIKit

struct Action {
    let actionTitle: String
    let onCompletion: (() -> Void)?
    let style: ActionStyle
}

enum ActionStyle {
    case cancel
    case basic
    case destructive
}

extension ActionStyle {
    var associatedAlertActionStyle: UIAlertAction.Style {
        switch self {
        case .basic:
            return.default
        case .cancel:
            return .cancel
        case .destructive:
            return .destructive
        }
    }
}
