//
//  DealsCollectionViewCell.swift
//  Store Project
//
//  Created by Arwa on 10/19/20.
//

import UIKit

class DealsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    
    
    @IBOutlet weak var Price: UILabel!
    
    
    @IBOutlet weak var Discount: UILabel!
    
    @IBOutlet weak var Percent: UILabel!
    
    
    
    
    func Update(Deals : DealsObject) {
        self.Name.text = Deals.Name
        self.Price.text = Deals.Price?.description
        self.Discount.text = Deals.Discount?.description
        
        guard let imgString = Deals.ImageURLs?[0], let url = URL(string: imgString) else { return }
        ImageView.sd_setImage(with: url, completed: nil)

}

}
