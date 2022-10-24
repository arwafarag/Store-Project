//
//  SectionTableViewCell.swift
//  Store Project
//
//  Created by Arwa Farag on 28/06/2021.
//

import UIKit

class SectionTableViewCell: UITableViewCell {

    @IBOutlet weak var Label: UILabel!
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    func UpDate(Section: SectionObject) {
        self.Label.text = Section.Name
        
        guard let strurl = Section.Image, let url = URL(string :strurl) else {return}
        self.ImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    
    
}
