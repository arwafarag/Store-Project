//
//  Sign In.swift
//  Store Project
//
//  Created by Arwa on 10/8/20.
//

import UIKit
import Firebase


class SignIn : UIViewController, UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingUpKeyboardNotifications()
    }
    
    @IBOutlet weak var BottomLayout: NSLayoutConstraint!
    
    @IBOutlet weak var EmailtextField : UITextField!
    
    @IBOutlet weak var PasswordtextField : UITextField!
    
    @IBAction func SignInButton(_ sender : UIButton){
      
        Auth.auth().signIn(withEmail: self.EmailtextField.text!, password: self.PasswordtextField.text!){  (auth, error) in
        
            if error == nil {
                print("Done signing in.")
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error.debugDescription)
            }
        
        }
    }
    
}
// Keyboard
extension SignIn {
    func SettingUpKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignIn.KeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignIn.KeyboardHid(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func KeyboardShow(notification : NSNotification) {
        if let KeyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.BottomLayout.constant = KeyboardSize.height
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}
    @objc func KeyboardHid(notification : NSNotification) {
       
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.BottomLayout.constant = 0
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

