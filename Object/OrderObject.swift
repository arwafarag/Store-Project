//
//  OrderObject.swift
//  Store Project
//
//  Created by Arwa on 1/9/21.
//

import UIKit
import FirebaseFirestore



class OrderObject {
    
    var ID : String?
    var ProductsIDs : [String]?
    var QuantityS : [Int]?
    var Stamp : TimeInterval?
    var UserID : String?
    var Status : String?
    
    init (ID: String, ProductsIDs: [String], QuantityS: [Int], Stamp: TimeInterval, UserID: String, Status: String) {
        self.ID = ID
        self.ProductsIDs = ProductsIDs
        self.QuantityS = QuantityS
        self.Stamp = Stamp
        self.UserID = UserID
        self.Status = Status
    }
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.ProductsIDs = Dictionary["ProductsIDs"] as? [String]
        self.QuantityS = Dictionary["QuantityS"] as? [Int]
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.UserID = Dictionary["UserID"] as? String
        self.Status = Dictionary["Status"] as? String
    }
    func MakeDictionary()->[String: AnyObject] {
        var dic : [String : AnyObject] = [:]
        dic["ID"] = self.ID as AnyObject?
        dic["ProductsIDs"] = self.ProductsIDs as AnyObject?
        dic["Stamp"] = self.Stamp as AnyObject?
        dic["UserID"] = self.UserID as AnyObject?
        dic["Status"] = self.Status as AnyObject?
        return dic
    }
   func Upload(){
       guard let id = self.ID else {return}
           Firestore.firestore().collection("Orders").document(id).setData(MakeDictionary())
   }
   func Remove(){
       guard let id = self.ID else {return}
    Firestore.firestore().collection("Orders").document(id).delete()
   }
}
