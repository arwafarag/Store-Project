//
//  MyProductVC.swift
//  Store Project
//
//  Created by Arwa on 12/10/20.
//

import UIKit



class MyProductsVC : UIViewController {
    
    var RefreshControl : UIRefreshControl = UIRefreshControl()
    
    
    var Products: [ProductObject] = []
    
    @IBOutlet weak var CollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        SetUpRefresher()
        GetData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MyProductsVC.Reloaddata), name: NSNotification.Name(rawValue: "ReloadProducts"), object: nil)
        
        
    }
    @objc func Reloaddata(){
        self.Products = []
        self.CollectionView.reloadData()
        GetData()
    }
    func GetData(){
        ProductApi.GetAllProduct { (Product: ProductObject) in
            self.Products.append(Product)
            self.CollectionView.reloadData()
        }
    }
    
}
extension MyProductsVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCollectionViewCell
        Cell.Update(Product: self.Products[indexPath.row])
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.33, height: collectionView.frame.size.width * 0.55)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let SelectedProduct = Products[indexPath.row]
        performSegue(withIdentifier: "Next", sender: SelectedProduct)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let next = segue.destination as? AddNewProductVC {
            
            if let product = sender as? ProductObject {
                next.EditingProduct = product
            }
        }
        
    }
    
}
extension MyProductsVC {
    func SetUpRefresher(){
        self.RefreshControl.addTarget(self, action: #selector(MyProductsVC.RefreshNow), for: .valueChanged)
        RefreshControl.tintColor = UIColor.orange
        self.CollectionView.addSubview(self.RefreshControl)
    }
    @objc func RefreshNow(){
        self.Products = []
        self.CollectionView.reloadData()
        self.GetData()
        self.RefreshControl.endRefreshing()
    }
    
}
