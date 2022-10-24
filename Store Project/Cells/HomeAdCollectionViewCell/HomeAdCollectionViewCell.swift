//
//  HomeAdCollectionViewCell.swift
//  Store Project
//
//  Created by Arwa on 10/9/20.
//

import UIKit
import SDWebImage

class HomeAdCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var ImageView: UIImageView!
    
    func Update(AD : AdObject) {
        
        if let str = AD.ImageURL, let url = URL(string: str) {
            
            ImageView.sd_setImage(with: url, completed: nil)
//            self.ImageView.contentMode = .scaleAspectFill
        }
    }

}
