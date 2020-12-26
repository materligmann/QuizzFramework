//
//  String+Internationalization.swift
//  lastProject
//
//  Created by Mathias Erligmann on 16/07/2020.
//  Copyright © 2020 100-8 Studio. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
}
