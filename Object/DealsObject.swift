//
//  DealsObject.swift
//  Store Project
//
//  Created by Arwa on 1/9/21.
//

import Foundation
import FirebaseFirestore

class DealsObject {
    var ID : String?
    var Stamp : TimeInterval?
    
    var Name : String?
    var Description : String?
    
    var Company : String?
    var Price: Double?
    var Discount : Double?
    var ImageURLs : [String]?
    
    init(ID: String, Stamp: TimeInterval, Name: String, Description: String, Company: String, Price: Double, Discount: Double, ImageURLs : [String] ) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.Description = Description
        self.Company = Company
        self.Price = Price
        self.Discount = Discount
        self.ImageURLs = ImageURLs
    }
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.Description = Dictionary["Description"] as? String
        self.Company = Dictionary["Company"] as? String
        self.Price = Dictionary["Price"] as? Double
        self.Discount = Dictionary["Discount"] as? Double
        self.ImageURLs = Dictionary["ImageURLs"] as? [String]
    }
    func MakeDictionary()->[String : AnyObject] {
        var L : [String : AnyObject] = [:]
        L["ID"] = self.ID as AnyObject
        L["Stamp"] = self.Stamp as AnyObject
        L["Name"] = self.Name as AnyObject
        L["Description"] = self.Description as AnyObject
        L["Company"] = self.Company as AnyObject
        L["Price"] = self.Price as AnyObject
        L["Discount"] = self.Discount as AnyObject
        L["ImageURLs"] = self.ImageURLs as AnyObject
        return L
    }
    func Upload(){
        guard let id = self.ID else {return}
            Firestore.firestore().collection("Deals").document(id).setData(MakeDictionary())
    }
    func Remove(){
        guard let id = self.ID else {return}
        Firestore.firestore().collection("Deals").document(id).delete()
        Firestore.firestore().collection("Products").document(id).delete()
        
    }
}


class DealsApi {
    static func GetDeals(ID: String, completion : @escaping (_ user : DealsObject)->()){
        Firestore.firestore().collection("Deals").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = DealsObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetUser(ID: String, completion : @escaping (_ user : DealsObject)->()){
        Firestore.firestore().collection("Deals").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = DealsObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllDeals(completion : @escaping (_ user : DealsObject)->()) {
        Firestore.firestore().collection("Deals").getDocuments { (Snapshot, error) in
            if error != nil {print("Error") ; return}
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data =  P.data() as [String : AnyObject]? {
                    let New = DealsObject(Dictionary: data)
                    completion(New)
        }
           
    }
    
}
        
}
    
    
    
    
    
    
    
}
