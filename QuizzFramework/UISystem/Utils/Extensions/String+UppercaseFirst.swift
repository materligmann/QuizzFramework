//
//  String+UppercaseFirst.swift
//  GoGo
//
//  Created by Mathias Erligmann on 26/11/2020.
//

import Foundation

extension String {
    func uppercaseFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }

//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
}
