//
//  StartingVC.swift
//  Store Project
//
//  Created by Arwa on 10/8/20.
//

import UIKit
import  Firebase

class StartingVC : UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if user == nil {
                self.performSegue(withIdentifier: "Auth", sender: nil)
                // user not here
            }else {
                self.performSegue(withIdentifier: "App", sender: nil)
                //user is here
        }
    }
  }
    
    
}
    
