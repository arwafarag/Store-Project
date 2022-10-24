//
//  Forget Password.swift
//  Store Project
//
//  Created by Arwa on 10/8/20.
//

import UIKit
import Firebase

class ForgotPassword : UIViewController {
 
    @IBOutlet weak var EmailTextField: UITextField!
    
    
    @IBAction func ResetPasswordAction(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: EmailTextField.text!, completion: nil)
    
    }
    
    @IBAction func SignInAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
    }
    
}
