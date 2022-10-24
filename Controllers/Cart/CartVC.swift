//
//  CartVC.swift
//  Store Project
//
//  Created by Arwa on 1/10/21.
//

import Foundation
import UIKit
import Firebase

class CartVC : UIViewController {
    
    
    @IBAction func OrderButtonAction(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let userid = user?.uid {
                
                let IDs : [String] = self.Products.map({ return $0.ID! })
                let Quantity : [Int] = self.Products.map({ return $0.Quantity! })
//                
//                var arr : [(String, Int)] = []
//                
//                for (index, ids) in IDs.enumerated(){
//                    arr.append((ids,Quantity[index]))
//                }
                
                
                let NOrder = OrderObject(ID: UUID().uuidString, ProductsIDs: IDs , QuantityS: Quantity , Stamp: Date().timeIntervalSince1970, UserID: userid, Status: "Pending")
                
                NOrder.Upload()
                
                
//                Pending- Shipping- Received
//                                   - Canceled
            
        }
        }
       
        
    }
    
    var Products : [ProductObject] = []
    
    
    @IBOutlet weak var TableView : UITableView! {didSet {TableView.delegate = self ; TableView.dataSource = self } }
    
    
    @IBAction func NextButton(_sender : UIButton){
        
    }
    
    func GetCart(){
        CartManager.GetAll { (Product : ProductObject) in
            self.Products.append(Product)
            DispatchQueue.main.async {
                self.TableView.reloadData()
                self.CalculateNumbers()
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        GetCart()
    }
    
    func CalculateNumbers() {
        var PCost : Double = 0
        for one in self.Products {
            PCost = PCost + (one.Price ?? 0.0)
        }
        
        self.ProductsCost.text = String(PCost) + "$"
        
        self.ShippingCost.text = String(self.Products.count * 3) + "$"
        
        self.TotalCost.text = String(PCost + Double(self.Products.count * 3)) + "$"
        
    }
    @IBOutlet weak var ProductsCost: UILabel!
    
    
    @IBOutlet weak var ShippingCost: UILabel!
    
    @IBOutlet weak var TotalCost: UILabel!
    
    
    @IBAction func OrderNow(_ sender: Any) {
    }
    
}
extension CartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductTableViewCell
        cell.Update(Product: self.Products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CartManager.Remove(Product: self.Products[indexPath.row])
            self.Products.remove(at: indexPath.row)
            self.TableView.deleteRows(at: [indexPath], with: .automatic)
            self.CalculateNumbers()
        }
    }
    
    
    
    
    
    
    
}
