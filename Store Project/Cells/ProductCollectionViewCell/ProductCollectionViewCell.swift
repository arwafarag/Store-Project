//
//  ProductCollectionViewCell.swift
//  Store Project
//
//  Created by Arwa on 10/18/20.
//

import UIKit


class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    func Update(Product : ProductObject) {
        self.Name.text = Product.Name
        self.Price.text = Product.Price?.description
        
        guard let imgString = Product.ImageURLs?[0], let url = URL(string: imgString) else { return }
        ImageView.sd_setImage(with: url, completed: nil)

}
}
