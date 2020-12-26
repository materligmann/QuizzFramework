//
//  Quizz.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 24/12/2020.
//

import Foundation

struct Quizz {
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
        var rightnesses = [Rightness]()
        var score = 0
        for question in questions {
            if let rightness = question.getRightness() {
                if rightness.isRight {
                    score += 1
                }
                rightnesses.append(rightness)
            }
        }
        return Summary(score: score, numberOfQuestions: questions.count, rightnesses: rightnesses)
    }
    
    mutating func loadNextQuestion() -> NextQuestionResult {
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
