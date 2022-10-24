//
//  ProductObject.swift
//  Store Project
//
//  Created by Arwa on 10/23/20.
//

import Foundation
import FirebaseFirestore


class ProductObject {
    
    var ID : String?
    var Stamp : TimeInterval?
    
    var Name : String?
    var Description : String?
    
    var Company : String?
    var Price: Double?
    
    var Quantity : Int?
    
    var ImageURLs : [String]?
    var SectionID : String?
    
    init(ID: String, Stamp: TimeInterval,SectionID: String, Name: String, Description: String, Company: String, Price: Double, ImageURLs : [String] ) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.Description = Description
        self.Company = Company
        self.Price = Price
        self.ImageURLs = ImageURLs
        self.SectionID = SectionID
    }
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.Description = Dictionary["Description"] as? String
        self.Company = Dictionary["Company"] as? String
        self.Price = Dictionary["Price"] as? Double
        self.ImageURLs = Dictionary["ImageURLs"] as? [String]
        self.SectionID = Dictionary["SectionID"] as? String
    }
    func MakeDictionary()->[String : AnyObject] {
        var D : [String : AnyObject] = [:]
        D["ID"] = self.ID as AnyObject
        D["Stamp"] = self.Stamp as AnyObject
        D["Name"] = self.Name as AnyObject
        D["Description"] = self.Description as AnyObject
        D["Company"] = self.Company as AnyObject
        D["Price"] = self.Price as AnyObject
        D["ImageURLs"] = self.ImageURLs as AnyObject
        D["SectionID"] = self.SectionID as AnyObject
        return D
    }
    func Upload(){
        guard let id = self.ID else {return}
        Firestore.firestore().collection("Products").document(id).setData(MakeDictionary())
    }
    func Remove(){
        guard let id = self.ID else {return}
        Firestore.firestore().collection("Products").document(id).delete()
        Firestore.firestore().collection("Ads").document(id).delete()
        
    }
}


class ProductApi {
    static func GetProduct(ID: String, completion : @escaping (_ user : ProductObject)->()){
        Firestore.firestore().collection("Products").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = ProductObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetUser(ID: String, completion : @escaping (_ user : ProductObject)->()){
        Firestore.firestore().collection("Products").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = ProductObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllProduct(completion : @escaping (_ user : ProductObject)->()) {
        Firestore.firestore().collection("Products").getDocuments { (Snapshot, error) in
            if error != nil {print("Error") ; return}
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data =  P.data() as [String : AnyObject]? {
                    let New = ProductObject(Dictionary: data)
                    completion(New)
                }
                
            }
            
        }
        
    }
    static func GetAllProduct(SectionID: String , completion : @escaping (_ user : ProductObject)->()) {
        let path = Firestore.firestore().collection("Products").whereField("SectionID", isEqualTo: SectionID)
        path.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
            for P in documents {
            path.getDocuments { (Snapshot, error) in
                if error != nil {print("Error") ; return}
                guard let documents = Snapshot?.documents else { return }
                for P in documents {
                    if let data =  P.data() as [String : AnyObject]? {
                        let New = ProductObject(Dictionary: data)
                        completion(New)
                    }
                }
            }
            }
        }
        
    }
}
