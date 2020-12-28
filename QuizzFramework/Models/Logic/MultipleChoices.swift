//
//  MultipleChoices.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class MultipleChoices {
    let correctChoices: [Choice]
    let incorrectChoices: [Choice]
    let aggregatedShuffledChoices: [Choice]
    
    private var answers: [Choice]?
    private var rightness: Rightness!
    
    init(correctChoices: [Choice], incorrectChoices: [Choice]) {
        self.correctChoices = correctChoices
        self.incorrectChoices = incorrectChoices
        self.aggregatedShuffledChoices = (correctChoices + incorrectChoices).shuffled()
    }
    
    func computeRightness() {
        var checks = [Check]()
        var isRight = true
        for choice in aggregatedShuffledChoices {
            let isCorrect = correctChoices.contains(choice)
            let isSelected = answers?.contains(choice) ?? false
            if isCorrect != isSelected {
                isRight = false
            }
            let check = Check(choice: choice,
                              isCorrect: isCorrect,
                              selected: isSelected)
            checks.append(check)
        }
        rightness = Rightness(checks: checks, isRight: isRight)
    }
    
    func addAnswer(choice: Choice) {
        if let answers = self.answers {
            if answers.contains(choice) {
                for (i, answer) in answers.enumerated() where answer == choice {
                    self.answers?.remove(at: i)
                }
            } else {
                self.answers?.append(choice)
            }
        } else {
            answers = [choice]
        }
    }
}

extension MultipleChoices: Proceedable {
    func canProceed() -> Bool {
        if answers != nil {
            return true
        }
        return false
    }
}

extension MultipleChoices: Verifiable {
    func getRightness() -> Rightness {
        return rightness
    }
}
