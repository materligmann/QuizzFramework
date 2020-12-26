//
//  Date+Strin.swift
//  GoGo
//
//  Created by Mathias Erligmann on 24/11/2020.
//

import Foundation

extension Date {
    func toString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
}
