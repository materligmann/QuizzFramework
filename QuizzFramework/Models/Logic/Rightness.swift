//
//  Rightness.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

struct Rightness {
    let checks : [Check]
    let isRight: Bool
}

struct Check {
    let choice: Choice
    let isCorrect: Bool
    let selected: Bool
}
