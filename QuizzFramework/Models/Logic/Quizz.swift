//
//  Quizz.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

class Quizz {
    private let questions: [Question]
    
    private var currentQuestionIndex: Int
    
    init(questions: [Question]) {
        currentQuestionIndex = 0
        self.questions = questions
    }
    
    func getCurrentQuestion() -> Question {
        return questions[currentQuestionIndex]
    }
    
    func computeSummary() -> Summary {
        var corrections = [Correction]()
        var score = 0
        for question in questions {
            if let rightness = question.getRightness() {
                if rightness.isRight {
                    score += 1
                }
                corrections.append(Correction(question: question, rightness: rightness))
            }
        }
        return Summary(score: score, corrections: corrections)
    }
    
    func loadNextQuestion() -> NextQuestionResult {
        if getCurrentQuestion().choices.type.canProceed() {
            if currentQuestionIndex != questions.count - 1 {
                currentQuestionIndex += 1
                return .yes
            }
            return .end
        }
        return .notAnswered
    }
}
