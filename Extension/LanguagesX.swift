//
//  LanguagesX.swift
//  Store Project
//
//  Created by Arwa on 1/9/21.
//

import UIKit


class LangButton : UIButton {
    
    @IBInspectable var Arabic : String = "" { didSet { self.Updatelang() } }
    @IBInspectable var English : String = "" { didSet { self.Updatelang() } }
    
    func Updatelang() {
        if GetLang() == .Arabic {
            self.setTitle(self.Arabic, for: .normal)
        } else if GetLang() == .English {
            self.setTitle(self.English, for: .normal)
        }
    }

    
}
