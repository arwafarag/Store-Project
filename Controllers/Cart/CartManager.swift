//
//  CartManager.swift
//  Store Project
//
//  Created by Arwa on 1/9/21.
//

import Foundation

class CartManager {
    
    
    //    how to separate between ID of Product and the quantity  "ABCD|7"
   static func ExtractInfo(Str: String) -> (ID : String, Quantity: Int){
        let arr = Str.components(separatedBy: "|")
        return (arr[0],Int(arr[1])!)
    }
    
    
    static func Add(Product : ProductObject, Quantitiy: Int){
        if let Data = UserDefaults.standard.array(forKey: "Cart") {
            var DataX = Data
            var New = true
            for (index,one) in (Data as! [String]).enumerated() {
                if Product.ID! == self.ExtractInfo(Str: one).ID {
                    DataX.remove(at: index)
                    DataX.insert(Product.ID! + "|" + Quantitiy.description, at: index)
                    UserDefaults.standard.set(DataX, forKey: "Cart")
                    New = false
                }
            }
            if New == true {
                //    i added ID and the quantity at the same time
                DataX.append(Product.ID! + "|" + Quantitiy.description)
                UserDefaults.standard.set(DataX, forKey: "Cart")
            }
            } else {
                UserDefaults.standard.set([(Product.ID! + "|" + Quantitiy.description)], forKey: "Cart")
            }
        }
       static func Remove(Product : ProductObject){
            if let Data = UserDefaults.standard.array(forKey: "Cart") {
                var DataX = Data
                for (index,one) in DataX.enumerated() {
                    if Product.ID! == ExtractInfo(Str: one as! String).ID {
                        DataX.remove(at: index)
                    }
                }
                UserDefaults.standard.set(DataX, forKey: "Cart")
            }
        }
       static func GetAll(completion : @escaping (_ Product : ProductObject)->()){
            if let Data = UserDefaults.standard.stringArray(forKey: "Cart") {
                for one in Data as! [String] {
                    
                    ProductApi.GetProduct(ID: ExtractInfo(Str: one).ID) { (pro) in
                        let p = pro
                        p.Quantity = self.ExtractInfo(Str: one).Quantity
                        completion(p)
                    }
                }
            }
        }
    }
