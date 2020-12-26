//
//  MessageModel.swift
//  GoGo
//
//  Created by Mathias Erligmann on 24/11/2020.
//

import Foundation

struct Message {
    let title: String
    let body: String
    let onCompletion: (() -> Void)?
    let actions: [Action]?
    
    static func basicErrorModel(body: String?) -> Message {
        let defaultBody = "Something went wrong"
        return Message(title: "Error", body: body ?? defaultBody, onCompletion: nil, actions: nil)
    }
    
    static func basicSuccessModel(body: String?) -> Message {
        let defaultBody = "Action was succesful"
        return Message(title: "Success", body: body ?? defaultBody, onCompletion: nil, actions: nil)
    }
}
