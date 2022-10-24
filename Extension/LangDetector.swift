//
//  LangDetector.swift
//  Store Project
//
//  Created by Arwa on 1/9/21.
//

import Foundation

enum Languages {
    case Arabic
    case English
}


func GetLang() ->Languages {
    

    let preferredLanguage = Locale.preferredLanguages[0] as String
    let lang = preferredLanguage.split(separator: "-")

    if lang[0] == "ar" {
        return .Arabic
    } else if lang[0] == "en" {
        return .English
    } else {
        return .English
    }

}
