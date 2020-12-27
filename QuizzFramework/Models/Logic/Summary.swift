//
//  Summary.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

struct Summary {
    let score: Int
    let corrections: [Correction]
}

struct Correction: Equatable {
    static func == (lhs: Correction, rhs: Correction) -> Bool {
        return lhs.question == rhs.question && lhs.rightness == rhs.rightness
    }
    
    let question: Question
    let rightness: Rightness
}
