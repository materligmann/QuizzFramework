//
//  Choice.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

struct Choice: Equatable, Codable {
    let statement: String
}

extension Choice {
    func isValid(given choices: [Choice]) -> Bool {
        var result = false
        for choice in choices {
            if choice == self {
                result = true
            }
        }
        return result
    }
}
