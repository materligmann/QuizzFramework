//
//  Bundle+Internationalization.swift
//  lastProject
//
//  Created by Mathias Erligmann on 16/07/2020.
//  Copyright © 2020 100-8 Studio. All rights reserved.
//

import Foundation

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = LanguageManager.getDeviceLanguage()
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        return bundle
    }
    
    public static func setLanguage(lang: String) {
        LanguageManager.setLanguage(lang: lang)
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}
