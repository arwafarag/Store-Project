//
//  ImageCollectionViewCell.swift
//  Store Project
//
//  Created by Arwa on 12/10/20.
//

import UIKit
import SDWebImage


class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    
    
    func Update(url: String) {
        guard let Url = URL(string: url) else { return }
        self.ImageView?.sd_setImage(with: Url, completed: nil)
        
    }
    
    func Updated(Image : UIImage) {
        self.ImageView.image = Image
    }

}
