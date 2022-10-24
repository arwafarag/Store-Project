//
//  Sign Up.swift
//  Store Project
//
//  Created by Arwa on 10/8/20.
//

import UIKit
import Firebase

class SignUp : UIViewController, UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
           self.view.endEditing(true)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingUpKeyboardNotifications()
    }
    
    @IBOutlet weak var EmailT: UITextField!
    
    @IBOutlet weak var PasseordT: UITextField!
    
    @IBOutlet weak var ConfirmPasswordT: UITextField!
    
    @IBOutlet weak var BottomLayoutSignUp: NSLayoutConstraint!
    
    @IBAction func SignUpAction(_ sender: Any) {
        if ConfirmPasswordT.text != PasseordT.text {
            // the password is not matching the confirm password
            return
        }
        Auth.auth().createUser(withEmail: EmailT.text!, password: PasseordT.text!) {(auth, error) in
            
            if error == nil {
                print("Done signing up.")
                Auth.auth().addStateDidChangeListener { (auth, user) in
                    guard let User = user else {return}
                    print(User.uid)
                    Firestore.firestore().collection("Users").document(User.uid).setData(["Email": self.EmailT.text! ])
                }
                
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            } else {
                print(error.debugDescription)
                if let err = error {
                    MessageBox.Show(Text: FireError.Error(Code: err._code))
                }
            }
        }
    }
    @IBAction func SignInAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


class FireError {
    
    static func Error(Code : Int) ->String {
        
        if let TheError = AuthErrorCode(rawValue: Code) {
            
            switch TheError {
            case .emailAlreadyInUse:
                return "This email already in use"
            case .weakPassword:
                return "This password weak"
            case .networkError:
                return "No conection try again later"
            case .userNotFound:
                return "User not found"
            case .invalidEmail:
                return "Invalid Email"
            case .wrongPassword:
                return "Wrong password"
            default:
                return "Unknow Error"
            }
        }
        return "Unknow Error"
    }
}
extension SignUp {
    func SettingUpKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(SignUp.KeyboardShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUp.KeyboardHid(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardShow(notification : NSNotification) {
        if let KeyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
                self.BottomLayoutSignUp.constant = KeyboardSize.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    @objc func KeyboardHid(notification : NSNotification) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.BottomLayoutSignUp.constant = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
