//
//  Font.swift
//  GoGo
//
//  Created by Mathias Erligmann on 22/11/2020.
//

import UIKit

extension UIFont {
    @nonobjc class var titleFont: UIFont {
        return UIFont.systemFont(ofSize: 30, weight: .heavy)
    }
    
    @nonobjc class var textFieldFont: UIFont {
        return UIFont.systemFont(ofSize: 25, weight: .regular)
    }
    
    @nonobjc class var placeholderFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    @nonobjc class var valueFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    @nonobjc class var buttonFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .semibold)
    }

}
