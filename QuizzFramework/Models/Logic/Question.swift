//
//  Question.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

struct Question: Equatable {
    
    let statement: String
    let choices: Choices
    let explanation: String?
    
    init(statement: String, choices: Choices, explanation: String?) {
        self.statement = statement
        self.choices = choices
        self.explanation = explanation
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
    
    func computeRightness() {
        choices.type.computeRightness()
    }
}
