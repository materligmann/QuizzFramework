//
//  QuizzWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation
import Alamofire

class QuizzWorker {
    
    static let shared = QuizzWorker()
    
    private init() {}
    typealias JSON = [String: Any]
    
    func getQuizzFromServer(completion: @escaping (Quizz?)-> Void) {
        let endPoint = "https://materligmann.github.io/quizz.json"
        AF.request(endPoint, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? JSON {
                    guard let quizz = self.decodeQuizz(json: json) else { return }
                    completion(quizz)
                }
            case .failure:
                completion(nil)
            }
        }
    }
    
    func decodeQuizz(json: JSON) -> Quizz? {
        print(json)
        if let quizz = json["quizz"] as? JSON {
            guard let questions = decodeQuestions(quizz: quizz) else { return nil }
            return Quizz(questions: questions)
        }
        return nil
    }
    
    func decodeQuestions(quizz: JSON) -> [Question]? {
        if let questionsJSON = quizz["questions"] as? [JSON] {
            var questions = [Question]()
            for questionJson in questionsJSON {
                guard let statement = decodeStatement(json: questionJson) else { return nil }
                guard let choices = decodeChoices(question: questionJson) else { return nil }
                let question = Question(statement: statement, choices: choices)
                questions.append(question)
            }
            if !questions.isEmpty {
                return questions
            }
        }
        return nil
    }
    
    func decodeChoices(question: JSON) -> Choices? {
        if let choices = question["choices"] as? JSON {
            guard let typeSlug = decodeType(choices: choices) else { return nil }
            let type: ChoicesType
            switch typeSlug {
            case "single":
                guard let singleChoices = decodeSingleChoices(choices: choices) else { return nil }
                type = .single(singleChoices)
            case "multiple":
                guard let multipleChoices = decodeMultipleChoices(choices: choices) else { return nil }
                type = .multiple(multipleChoices)
            default:
                return nil
            }
            return Choices(type: type)
        }
        return nil
    }
    
    func decodeType(choices: JSON) -> String? {
        if let typeSlug = choices["type"] as? String {
            return typeSlug
        }
        return nil
    }
    
    func decodeSingleChoices(choices: JSON) -> SingleChoices? {
        if let correctChoiceJson = choices["correctChoice"] as? JSON,
           let incorrectChoiceJson = choices["incorrectChoices"] as? [JSON] {
            guard let correctChoice = decodeChoice(json: correctChoiceJson) else { return nil }
            guard let incorrectChoices = decodeChoiceArray(jsonArray: incorrectChoiceJson) else { return nil }
            return SingleChoices(correctChoice: correctChoice, incorrectChoices: incorrectChoices)
        }
        return nil
    }
    
    func decodeMultipleChoices(choices: JSON) -> MultipleChoices? {
        if let correctChoiceJson = choices["correctChoice"] as? [JSON],
           let incorrectChoiceJson = choices["incorrectChoices"] as? [JSON] {
            guard let correctChoice = decodeChoiceArray(jsonArray: correctChoiceJson) else { return nil }
            guard let incorrectChoices = decodeChoiceArray(jsonArray: incorrectChoiceJson) else { return nil }
            return MultipleChoices(correctChoices: correctChoice, incorrectChoices: incorrectChoices)
        }
        return nil
    }
    
    func decodeChoice(json: JSON) -> Choice? {
        guard let statement = decodeStatement(json: json) else { return nil }
        return Choice(statement: statement)
    }
    
    func decodeChoiceArray(jsonArray: [JSON]) -> [Choice]? {
        var choices = [Choice]()
        for json in jsonArray {
            guard let choice = decodeChoice(json: json) else { return nil }
            choices.append(choice)
        }
        if !choices.isEmpty {
            return choices
        }
        return nil
    }
    
    func decodeStatement(json: JSON) -> String? {
        if let statement = json["statement"] as? String {
            return statement
        }
        return nil
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getQuizz() -> Quizz {
        let questions = getQuizzQuestions()
        return Quizz(questions: questions)
    }
    
    func getQuizzQuestions() -> [Question] {
        return [
            Question(statement: "Who created Ethereum ?",
                     choices:
                        Choices(type:
                                    .single(
                                        SingleChoices(
                                                correctChoice: Choice(statement: "Vitalik"),
                                                incorrectChoices: [
                                                    Choice(statement: "Satoshi Nakamote"),
                                                    Choice(statement: "Bill Gates")
                                                ]
                                        )
                                    )
                        )
            ),
            Question(statement: "Who created Bitcoin ?",
                     choices:
                        Choices(type:
                                    .single(
                                        SingleChoices(
                                                correctChoice: Choice(statement: "Satoshi Nakamoto"),
                                                incorrectChoices: [
                                                    Choice(statement: "Vitalik"),
                                                    Choice(statement: "Bill Gates")
                                                ]
                                        )
                                    )
                        )
            ),
            Question(statement: "Who created Microsoft ?",
                     choices:
                        Choices(type:
                                    .single(
                                        SingleChoices(
                                                correctChoice: Choice(statement: "Bill Gates"),
                                                incorrectChoices: [
                                                    Choice(statement: "Satoshi Nakamoto"),
                                                    Choice(statement: "Vitalik")
                                                ]
                                        )
                                    )
                        )
            ),
            Question(statement: "Who founded Apple ?",
                     choices:
                        Choices(type:
                                    .multiple(
                                        MultipleChoices(
                                            correctChoices: [
                                                Choice(statement: "Steve Jobs"),
                                                Choice(statement: "Steve Wozniak")
                                            ],
                                            incorrectChoices: [
                                                Choice(statement: "Vitalik"),
                                                Choice(statement: "Satoshi Nakamoto"),
                                                Choice(statement: "Bill Gates")
                                            ]
                                        )
                                    )
                        )
            )
        ]
    }
    
//    private func getQuizzQuestions() -> [Question] {
//        return [
//            Question(statement: "Who created Ethereum ?",
//                     answers: Choices(
//                        correct: [
//                            Answer(statement: "Vitalik")
//                        ],
//                        incorrect: [
//                            Answer(statement: "Satoshi Nakamote"),
//                            Answer(statement: "Bill Gates")
//                        ]
//                     )
//            ),
//            Question(statement: "Who created Bitcoin ?",
//                     answers: Choices(
//                        correct: [
//                            Answer(statement: "Satoshi Nakamoto")
//                        ],
//                        incorrect: [
//                            Answer(statement: "Vitalik"),
//                            Answer(statement: "Bill Gates")
//                        ]
//                     )
//            ),
//            Question(statement: "Who created Microsoft ?",
//                     answers: Choices(
//                        correct: [
//                            Answer(statement: "Bill Gates")
//                        ],
//                        incorrect: [
//                            Answer(statement: "Satoshi Nakamoto"),
//                            Answer(statement: "Vitalik")
//                        ]
//                     )
//            ),
//        ]
//    }
}
