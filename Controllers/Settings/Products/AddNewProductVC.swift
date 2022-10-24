//
//  NewProductVC.swift
//  Store Project
//
//  Created by Arwa on 10/23/20.
//

import UIKit
import BSImagePicker
import Photos
import FirebaseStorage

class AddNewProductVC : UIViewController, SelectedSectionDelegate {
    
    func SelectedSection(Section: SectionObject) {
        self.SelectedSection = Section
        self.SelectSectionButton.setTitle(Section.Name ?? "" , for: .normal)
    }
    
    @IBOutlet weak var SelectSectionButton: UIButton!
 
    var SelectedSection : SectionObject?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? SectionsVC {
            next.delegate = self
            
            
        }
    }
   
    @IBAction func RemoveAction(_ sender: Any) {
        
        let Alert =  UIAlertController(title: "Remove Product", message: "Do you want to remove this product?", preferredStyle: .alert)
        
        let yesbutton = UIAlertAction(title: "yes", style: .destructive) { (yesButton) in
            
            self.EditingProduct?.Remove()
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("ReloadProduct"), object: nil, userInfo: nil)
        }
        let Nobutton = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        Alert.addAction(yesbutton)
        Alert.addAction(Nobutton)
        
        self.present(Alert, animated: true , completion: nil)
        
    }
    
    
    
    var Images : [UIImage] = []
    
    @IBAction func AdImageButtonAction(_ sender: Any) {
        
        presentImagePicker(BSVC, animated: true, select: { (PhAssets: PHAsset) in
            
        }, deselect: { (PhAssets: PHAsset) in
            
        }, cancel: { (PhAssets: [PHAsset]) in
            
        }, finish: { (PhAssets : [PHAsset]) in
            if PhAssets.count > 0 {
                let img = PhAssets[0]
                self.AdImageView.image = getUIImage(asset: img)
            }
            
        }, completion : nil)
    }
    
    
    
    
    @IBOutlet weak var AdImageView: UIImageView!
    
    
    var EditingProduct : ProductObject?
    
    
    
    @IBOutlet weak var Name: UITextField!
    
    @IBOutlet weak var Description: UITextView!
    
    @IBOutlet weak var Price: UITextField!
    
    @IBOutlet weak var Company: UITextField!
    
    @IBOutlet weak var CollectionView: UICollectionView! { didSet { CollectionView.delegate = self ; CollectionView.dataSource = self}}
    
    var BSVC = ImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        if let EditP = EditingProduct{
            self.Name.text = EditP.Name
            self.Description.text = EditP.Description
            self.Price.text = EditP.Price?.description
            self.Company.text = EditP.Company
            
            // fix
            //            if let str = EditP.ImageURL, let url = URL(string: str) {
            //            self.ImageView.sd_setImage(with: url, completed: nil)
            //        }
        }
    }
    
    @IBAction func UploadImage(_ sender: UIButton) {
        //        BSVC.maxNumberOfSelection = 5
        BSVC = ImagePickerController()
        presentImagePicker(BSVC, animated: true, select: { (PhAssets: PHAsset) in
            
        }, deselect: { (PhAssets: PHAsset) in
            
        }, cancel: { (PhAssets: [PHAsset]) in
            
        }, finish: { (PhAssets : [PHAsset]) in
            
            
            for one in PhAssets {
                if let img = getUIImage(asset: one) {
                    self.Images.append(img)
                }
            }
            self.CollectionView.reloadData()
            
            
        }, completion : nil)
    }
    
    func UploadManyImages(completoin : @escaping(_ URLs: [String]) ->()){
        var Counter = 0
        var UploadedImages : [String] = []
        for one in self.Images {
            one.Upload {(url) in
                UploadedImages.append(url)
                if self.Images.count == UploadedImages.count {
                    completoin(UploadedImages)
                }
            }
        }
    }
    
    @IBAction func UploadProduct(_ sender: Any) {
        self.performSegue(withIdentifier: "Loading", sender: nil)
        self.UploadManyImages { (URLs : [String]) in
            
            guard let section = self.SelectedSection else {return}
            let ProductID : String = self.EditingProduct?.ID ?? UUID().uuidString
            ProductObject(ID: ProductID , Stamp: Date().timeIntervalSince1970, SectionID: section.ID!, Name: self.Name.text!, Description: self.Description.text!, Company: self.Company.text!, Price: Double(self.Price.text!) ?? 0.0, ImageURLs: URLs).Upload()
            
            NotificationCenter.default.post(name: NSNotification.Name("ReloadProduct"), object: nil, userInfo: nil)
            
            print("product uploaded")
            
            if self.AdImageView.image == nil {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            self.UploadADForProduct(ProductID: ProductID)
        }
        
    }
    
    func UploadADForProduct(ProductID : String) {
        BSVC = ImagePickerController()
        self.AdImageView.image?.Upload(completion: { (ImageURL : String) in
            AdObject(ID: ProductID, Stamp: Date().timeIntervalSince1970, ImageURL: ImageURL, ProductID: ProductID).Upload()
            print("Ad uploaded")
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
    }
}


func getUIImage(asset: PHAsset) -> UIImage? {
    var img: UIImage?
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.version = .original
    options.isSynchronous = true
    manager.requestImageDataAndOrientation(for: asset, options: options) { (data, _, _, _) in
        if let data = data {
            img = UIImage(data: data)
        }
    }
    return img
}

extension AddNewProductVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        cell.Updated(Image: self.Images[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CollectionView.frame.size.height, height: collectionView.frame.size.height)
    }
}
