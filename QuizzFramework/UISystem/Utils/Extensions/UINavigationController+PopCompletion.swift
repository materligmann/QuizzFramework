//
//  UINavigationController+Completion.swift
//  GoGo
//
//  Created by Mathias Erligmann on 08/12/2020.
//

import UIKit

extension UINavigationController {
    func popViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
}
