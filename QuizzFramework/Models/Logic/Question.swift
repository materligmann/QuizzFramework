//
//  Question.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

class Question {
    let statement: String
    let choices: Choices
    
    init(statement: String, choices: Choices) {
        self.statement = statement
        self.choices = choices
    }
    
    func getAggregatedShuffleChoice() -> [Choice] {
        return choices.type.getAggregatedShuffleChoice()
    }
}

extension Question: Answerable {
    func select(choice: Choice) {
        choices.type.select(choice: choice)
    }
}

extension Question: Proceedable {
    func canProceed() -> Bool {
        return choices.type.canProceed()
    }
}

extension Question: Verifiable {
    func getRightness() -> Rightness? {
        return choices.type.getRightness()
    }
}
