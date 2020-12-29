//
//  QuizzesModels.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

enum QuizzesModels {
    struct Request {
        let quizzes: [QuizRef]
        let categoryName: String
    }
}
