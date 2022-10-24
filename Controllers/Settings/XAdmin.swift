//
//  XAdmin.swift
//  Store Project
//
//  Created by Arwa on 3/9/21.
//

import UIKit
import FirebaseDatabase

class XAdmin :UIViewController {
    static func IsAdmin(completion : @escaping ()->()) {
        Database.database().reference().child("AdminCanRead").observeSingleEvent(of: .value){
            (Snapshot) in
            if Snapshot.exists()  {
                completion()
                
            }
        }
        
    }
    
}
