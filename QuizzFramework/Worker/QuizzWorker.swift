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
    private var currentQuizz: Quiz?
    
    private init() {}
    typealias JSON = [String: Any]
    
    func setCurrentQuizz(quiz: Quiz) {
        currentQuizz = quiz
    }
    
    func getCurrentQuiz() -> Quiz? {
        return currentQuizz
    }
    
    func fetchQuiz(path: String, id: Int, completion: @escaping (Result<Quiz, Error>)-> Void) {
        let endPoint = "https://morning-caverns-85390.herokuapp.com/\(path)/\(id)"
        AF.request(endPoint, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? JSON {
                    guard let quiz = self.decodeQuizz(json: json) else { return }
                    completion(.success(quiz))
                }
            case .failure(let error as Error):
                completion(.failure(error))
            }
        }
    }
    
    func getCategoriesFromServer(completion: @escaping ([Category]?)-> Void) {
        let endPoint = "https://morning-caverns-85390.herokuapp.com/categories"
//        AF.request(endPoint, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let json = value as? JSON {
//                    guard let quizz = self.decodeQuizz(json: json) else { return }
//                    completion(quizz)
//                }
//            case .failure:
//                completion(nil)
//            }
//        }
        
        AF.request(endPoint, method: .get).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                if let json = value as? JSON {
                    guard let categories = self.decodeCategories(json: json) else { return }
                    completion(categories)
                }
            case .failure:
                completion(nil)
            }
        })
    }
    
    func decodeCategories(json: JSON) -> [Category]? {
        if let categoriesJsonArray = json["categories"] as? [JSON] {
            var categories = [Category]()
            for categoryJson in categoriesJsonArray {
                guard let name = categoryJson["name"] as? String else { return nil }
                guard let title = categoryJson["title"] as? String else { return nil }
                guard let imageName = categoryJson["imageName"] as? String else { return nil }
                guard let quizesJson = categoryJson["quizes"] as? [JSON] else { return nil }
                var quizes = [QuizRef]()
                for quiz in quizesJson {
                    guard let quizname = quiz["name"] as? String else { return nil }
                    guard let id = quiz["id"] as? Int else { return nil }
                    guard let imageName = quiz["imageName"] as? String else { return nil }
                    let quizeRef = QuizRef(name: quizname, id: id, imageName: imageName)
                    quizes.append(quizeRef)
                }
                categories.append(Category(name: name, title: title, imageName: imageName, quizes: quizes))
            }
            return categories
        }
        return nil
    }
    
    func decodeQuizz(json: JSON) -> Quiz? {
        print(json)
        if let quizz = json["quizz"] as? JSON {
            guard let questions = decodeQuestions(quizz: quizz) else { return nil }
            return Quiz(questions: questions, areQuestionSkipable: Settings.areQuestionsSkippable)
        }
        return nil
    }
    
    func decodeQuestions(quizz: JSON) -> [Question]? {
        if let questionsJSON = quizz["questions"] as? [JSON] {
            var questions = [Question]()
            for questionJson in questionsJSON {
                guard let statement = decodeStatement(json: questionJson) else { return nil }
                guard let choices = decodeChoices(question: questionJson) else { return nil }
                guard let explanation = decodeExplanation(question: questionJson) else { return nil }
                let question = Question(statement: statement, choices: choices, explanation: explanation)
                questions.append(question)
            }
            if !questions.isEmpty {
                return questions
            }
        }
        return nil
    }
    
    func decodeExplanation(question: JSON) -> String? {
        if let explanation = question["explanation"] as? String {
            return explanation
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
    
    
    func getQuizStub() -> Quiz {
        let questions = getQuizzQuestions()
        return Quiz(questions: questions, areQuestionSkipable: Settings.areQuestionsSkippable)
    }
    
    private func getQuizzQuestions() -> [Question] {
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
                        ), explanation: "Vitalik !"
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
                        ), explanation: "Satoshi Nakamoto"
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
                        ), explanation: "Bill Gates !"
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
                        ), explanation: "Steve Jobs and Steve Wozniak !"
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
