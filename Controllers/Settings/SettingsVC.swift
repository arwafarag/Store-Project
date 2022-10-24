//
//  AppVC.swift
//  Store Project
//
//  Created by Arwa on 10/8/20.
//

import UIKit
import Firebase

class SettingsVC : UIViewController {
    

    @IBOutlet weak var Admin: LangButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Admin.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        XAdmin.IsAdmin {
            DispatchQueue.main.async {
                self.Admin.isHidden = false
            }
        }
    }
     
    
//    @IBAction func SignOutButton(_ sender : UIButton) {
//        try?Auth.auth().signOut()
//        dismiss(animated: true, completion: nil)
//    }
    
    
    
}
