//
//  Quizz.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

class Quiz {
    private let questions: [Question]
    
    private var currentQuestionIndex: Int
    
    init(questions: [Question]) {
        currentQuestionIndex = 0
        self.questions = questions
    }
    
    func getCurrentQuestionIndex() -> Int {
        return currentQuestionIndex
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentQuestionIndex]
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
        if getCurrentQuestion().choices.type.canProceed() {
            if lastQuestion() {
                moveToNextQuestion()
                return .yes
            }
            return .end
        }
        if isSkippingAllowed && lastQuestion() {
            moveToNextQuestion()
        }
        return .notAnswered
    }
    
    private func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    private func lastQuestion() -> Bool {
        return currentQuestionIndex != questions.count - 1
    }
}
