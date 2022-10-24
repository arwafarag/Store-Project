//
//  MessageBox.swift
//  Store Project
//
//  Created by Arwa on 1/10/21.
//                              check if user found or not found


import Foundation
import UIKit

class MessageBoxVC : UIViewController {
    
    var Text : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.text = Text
    }
    @IBOutlet weak var label : UILabel!
    
    @IBAction func Done(){
        dismiss(animated: true, completion: nil)
    }
    
    
}
class MessageBox {
    
    static func Show(Text : String) {
        let storyBoard = UIStoryboard(name: "MessageBox", bundle: nil)
        let VC = storyBoard.instantiateViewController(identifier: "MessageBox") as! MessageBoxVC
        
        VC.Text = Text
        VC.modalTransitionStyle = .coverVertical
        VC.modalPresentationStyle = .overFullScreen
        
        UIApplication.getPresentedViewController()?.present(VC, animated: true, completion: nil)
    }
}

extension UIApplication {
    static func getPresentedViewController() ->UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        return presentViewController
    }

}



