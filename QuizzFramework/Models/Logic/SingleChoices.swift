//
//  SingleChoices.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class SingleChoices {
    let correctChoice: Choice
    let incorrectChoices: [Choice]
    let aggregatedShuffledChoices: [Choice]
    
    private var answer: Choice?
    private var rightness: Rightness?
    
    init(correctChoice: Choice, incorrectChoices: [Choice]) {
        self.correctChoice = correctChoice
        self.incorrectChoices = incorrectChoices
        var choices = incorrectChoices
        choices.append(correctChoice)
        self.aggregatedShuffledChoices = choices.shuffled()
    }
    
    func setAnswer(choice: Choice) {
        if choice.isValid(given: aggregatedShuffledChoices) {
            if self.answer == choice {
                self.answer = nil
            } else {
                self.answer = choice
            }
            computeRightness()
        }
    }
    
    func computeRightness() {
        var checks = [Check]()
        var isRight = true
        for choice in aggregatedShuffledChoices {
            let isCorrect = choice == correctChoice
            let isSelected = choice == answer
            if isCorrect != isSelected {
                isRight = false
            }
            let check = Check(choice: choice, isCorrect: isCorrect, selected: isSelected)
            checks.append(check)
        }
        rightness = Rightness(checks: checks, isRight: isRight)
    }
}

extension SingleChoices: Proceedable {
    func canProceed() -> Bool {
        if answer != nil {
            return true
        }
        return false
    }
}

extension SingleChoices: Verifiable {
    func getRightness() -> Rightness? {
        return rightness
    }
}
