//
//  ProductVC.swift
//  Store Project
//
//  Created by Arwa on 12/10/20.
//

import UIKit

class ProductVC : UIViewController {
    
    
    @IBAction func AddToCartButtonAction(_ sender: Any) {
        CartManager.Add(Product: self.Product, Quantitiy: counter)
        
        
    }
    var Product : ProductObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.TitleLabel.text = Product.Name
        self.DescriptionLabel.text = Product.Description
        self.CounterLabel.text = "1"
        self.PriceLabel.text = (Product.Price?.description ?? "") + "$"
    }
    
    
    @IBOutlet weak var CollectionView: UICollectionView! { didSet { CollectionView.delegate = self ; CollectionView.dataSource = self}}
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    var counter : Int = 1
    
    @IBAction func IncreaseButtonAction(_ sender: Any) {
        counter += 1
        CounterLabel.text = counter.description
    }
    
    @IBAction func DecreaseButtonAction(_ sender: Any) {
        counter -= 1
        CounterLabel.text = counter.description

    }
    
    @IBOutlet weak var CounterLabel: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    

}

extension ProductVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Product.ImageURLs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        if let img = self.Product.ImageURLs {
        Cell.Update(url: img[indexPath.row])
        }
//        Cell.ImageView.contentMode = .scaleAspectFill
       return Cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.CollectionView.frame.width, height: self.CollectionView.frame.height)
    }
    
}


