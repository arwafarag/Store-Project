//
//  HomeVC.swift
//  Store Project
//
//  Created by Arwa on 10/9/20.
//

import UIKit


class HomeVC : UIViewController {
    
    var ADArray : [AdObject] = []
    
    var ProductsArray: [ProductObject] = []
    
    var DealsArray: [DealsObject] = []
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    @IBOutlet weak var DealsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUPCollectionView()
        GetData()
    }
    
    func GetData(){
        ProductApi.GetAllProduct { (Product) in
            self.ProductsArray.append(Product)
            self.ProductCollectionView.reloadData()
        }
        AdApi.GetAllAds { (AD : AdObject) in
            self.ADArray.append(AD)
            self.collectionView.reloadData()
        }
        DealsApi.GetAllDeals {(Deals) in
            self.DealsArray.append(Deals)
            self.DealsCollectionView.reloadData()
        }
        
    }
}




// collection View Codes
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewlayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath)->CGSize {
        
        if collectionView.tag == 0 {
        return CGSize(width: self.view.frame.size.width, height: collectionView.frame.size.height)
        } else if collectionView.tag == 1 {
            return CGSize(width: collectionView.frame.size.height / 1.7 , height: collectionView.frame.size.height)
    }else if collectionView.tag == 2 {
        return CGSize(width: collectionView.frame.size.height / 1.7 , height: collectionView.frame.size.height)
}
      return CGSize()
    }
    
    
    func SetUPCollectionView(){
        collectionView.delegate = self ; collectionView.dataSource = self
        ProductCollectionView.delegate = self ; ProductCollectionView.dataSource = self
        DealsCollectionView.delegate = self; DealsCollectionView.dataSource = self
        
//        دي كده لما ال  cell تكون معموله في فايل لوحدها
        collectionView.register(UINib(nibName: "HomeAdCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "Cell")
        
        ProductCollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "Cell")
        
        DealsCollectionView.register(UINib(nibName: "DealsCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "Cell")
    }
    
    
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if collectionView.tag == 0 {
        return ADArray.count
    }else if collectionView.tag == 1 {
        return ProductsArray.count
    }else if collectionView.tag == 2{
        return DealsArray.count
    }
    
   return 0
}
    
    
    
    
    
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView.tag == 0 {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    as! HomeAdCollectionViewCell
    cell.Update(AD: ADArray[indexPath.row])
    return cell
        
    }else if collectionView.tag == 1 {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    as! ProductCollectionViewCell
    cell.Update(Product: ProductsArray[indexPath.row])
    return cell
        
    } else if collectionView.tag == 2 {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DealsCollectionViewCell
        return cell
    }
    return UICollectionViewCell()
}
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            ProductApi.GetProduct(ID: self.ADArray[indexPath.row].ID!) { (product) in
                self.performSegue(withIdentifier: "ShowProduct", sender: product)
            }
        } else if collectionView.tag == 1 {
            self.performSegue(withIdentifier: "ShowProduct", sender: self.ProductsArray[indexPath.row])

        }  else if collectionView.tag == 2 {
            self.performSegue(withIdentifier: "ShowProduct", sender: self.DealsArray[indexPath.row])
        }
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let product = sender as? ProductObject {
        if let next = segue.destination as? ProductVC {
            next.Product = product
   }
  }
 }
}
