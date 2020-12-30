//
//  Quizz.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

class Quiz {
    private let questions: [Question]
    private let areQuestionSkipable: Bool
    private var currentQuestionIndex: Int
    
    init(questions: [Question], areQuestionSkipable: Bool) {
        self.areQuestionSkipable = areQuestionSkipable
        currentQuestionIndex = 0
        self.questions = questions
    }
    
    func getCurrentQuestionIndex() -> Int {
        return currentQuestionIndex
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentQuestionIndex]
    }
    
    func isQuestionSkippable() -> Bool {
        return areQuestionSkipable
    }
    
    func computeSummary() -> Summary {
        var corrections = [Correction]()
        var score = 0
        for question in questions {
            let rightness = question.getRightness()
            if rightness.isRight {
                score += 1
            }
            corrections.append(Correction(question: question, rightness: rightness))
        }
        return Summary(score: score, corrections: corrections)
    }
    
    func loadNextQuestion(isSkippingAllowed: Bool) -> NextQuestionResult {
        let currentQuestion = getCurrentQuestion()
        if lastQuestion() {
            return .end
        }
        if currentQuestion.choices.type.canProceed() {
            moveToNextQuestion()
            return .yes
        } else if isSkippingAllowed {
            moveToNextQuestion()
            return .notAnswered
        } else {
            return .notAnswered
        }
    }
    
    private func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    private func lastQuestion() -> Bool {
        return currentQuestionIndex == questions.count - 1
    }
}
