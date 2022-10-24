//
//  AddNewSectionVC.swift
//  Store Project
//
//  Created by Arwa Farag on 25/06/2021.
//

import UIKit
import Photos
import BSImagePicker



class AddNewSectionVC : UIViewController , UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var Name: UITextField!
    
    
    var BSVC = ImagePickerController()
    
    
    @IBAction func AddSection(_ sender: Any) {
//        BSVC.maxNumberOfSelection = 1
        BSVC = ImagePickerController()
       
        
        presentImagePicker(BSVC, animated: true, select: nil, deselect: nil, cancel: nil, finish: { (PhAssets : [PHAsset]) in

            for one in PhAssets {
             if let img = getUIImage(asset: one) {

                DispatchQueue.main.async {
                    self.ImageView.image = img

                }
             }
            }
        } , completion: nil)
    
    }
    
    @IBOutlet weak var ImageView: UIImageView!
    var EditedSection : SectionObject?
    var NewID : String?
    
    @IBAction func UploadSection(_ sender: Any) {
        NewID = EditedSection?.ID ?? UUID().uuidString
        
        self.ImageView.image?.Upload(completion: { url in
            SectionObject(ID: self.NewID!, Name: self.Name.text!, Image: url, Stamp: Date().timeIntervalSince1970).Upload()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadSections"), object: nil, userInfo: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    @IBAction func Remove(_ sender: Any) {
        EditedSection?.Remove()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ReloadSections") , object: nil, userInfo: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
