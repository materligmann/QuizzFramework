//
//  AnswersType.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

enum ChoicesType {
    case single(SingleChoices)
    case multiple(MultipleChoices)
    
    func getAggregatedShuffleChoice() -> [Choice] {
        switch self {
        case .single(let single):
            return single.aggregatedShuffledChoices
        case .multiple(let multiple):
            return multiple.aggregatedShuffledChoices
        }
    }
}

extension ChoicesType: Proceedable {
    func canProceed() -> Bool {
        switch self {
        case .single(let single):
            return single.canProceed()
        case .multiple(let multiple):
            return multiple.canProceed()
        }
    }
}

extension ChoicesType: Answerable {
    func select(choice: Choice) {
        switch self {
        case .single(let single):
            return single.setAnswer(choice: choice)
        case .multiple(let multiple):
            return multiple.addAnswer(choice: choice)
        }
    }
}

extension ChoicesType: Verifiable {
    func getRightness() -> Rightness? {
        switch self {
        case .single(let single):
            return single.getRightness()
        case .multiple(let multiple):
            return multiple.getRightness()
        }
    }
}
