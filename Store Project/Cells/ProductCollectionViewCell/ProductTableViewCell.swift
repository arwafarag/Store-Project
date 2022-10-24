//
//  ProductTableViewCell.swift
//  Store Project
//
//  Created by Arwa on 1/10/21.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var TheView: UIView!
    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var Quantity: UILabel!
    
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    func Update(Product : ProductObject) {
        self.Quantity.text = Product.Quantity?.description
        self.TheView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.TheView.layer.borderWidth = 0.8
        self.Name.text = Product.Name
        self.Price.text = Product.Price?.description
        
        guard let imgString = Product.ImageURLs?[0], let url = URL(string: imgString) else { return }
        ImageView.sd_setImage(with: url, completed: nil)

}
    
}
