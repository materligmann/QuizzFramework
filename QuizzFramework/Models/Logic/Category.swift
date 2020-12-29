//
//  Category.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import Foundation

struct Category: Codable {
    let name: String
    let title: String
    let imageName: String
    let quizes: [QuizRef]
}
