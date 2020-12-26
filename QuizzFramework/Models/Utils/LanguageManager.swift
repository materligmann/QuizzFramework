//
//  LanguageManager.swift
//  lastProject
//
//  Created by Mathias Erligmann on 16/07/2020.
//  Copyright © 2020 100-8 Studio. All rights reserved.
//

import Foundation

class LanguageManager {
    
    static var languages = ["en", "fr"]
    private static var defaultLanguage = "en"
    private static var languageStoreKey = "app_lang"
    
    static func getDeviceLanguage() -> String {
        if let storedLanguage = getLanguage() {
            return storedLanguage
        }
        if let langStr = Locale.current.languageCode {
            if languages.contains(langStr) {
                setLanguage(lang: langStr)
                return langStr
            }
        }
        setLanguage(lang: defaultLanguage)
        return defaultLanguage
    }
    
    static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: languageStoreKey)
        UserDefaults.standard.synchronize()
    }
    
    private static func getLanguage() -> String? {
        return UserDefaults.standard.string(forKey: languageStoreKey)
    }
}
