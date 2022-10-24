//
//  SectionObject.swift
//  Store Project
//
//  Created by Arwa on 3/27/21.
//

import Foundation
import FirebaseFirestore
class SectionObject {
    
    var ID : String?
    var Name : String?
    var Image : String?
    var Stamp : TimeInterval?
    
    
    var Selected : Bool = false
    
    init(ID: String, Name: String, Image: String, Stamp: TimeInterval){
        self.ID = ID
        self.Name = Name
        self.Image = Image
        self.Stamp = Stamp
    }
    init(Dictionary: [String:AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Name = Dictionary["Name"] as? String
        self.Image = Dictionary["Image"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
    }
    func GetDictionary()-> [String: AnyObject]{
        var Dic : [String: AnyObject] = [:]
        Dic["ID"] = self.ID as AnyObject
        Dic["Name"] = self.Name as AnyObject
        Dic["Image"] = self.Image as AnyObject
        Dic["Stamp"] = self.Stamp as AnyObject
        return Dic
    }
    
    func Upload(){
        guard let id = self.ID else {return}
            Firestore.firestore().collection("Sections").document(id).setData(GetDictionary())
    
    }
    func Remove(){
        guard let id = self.ID else {return}
        Firestore.firestore().collection("Sections").document(id).delete()
        
    }
}
class SectionApi {
    static func GetSection(ID: String, completion : @escaping (_ user : SectionObject)->()){
        Firestore.firestore().collection("Sections").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = SectionObject(Dictionary: data)
                completion(New)
            }
        }
    }
    static func GetUser(ID: String, completion : @escaping (_ user : SectionObject)->()){
        Firestore.firestore().collection("Sections").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = SectionObject(Dictionary: data)
                completion(New)
            }
        }
    }
    
    static func GetAllSections(completion : @escaping (_ user : SectionObject)->()) {
        Firestore.firestore().collection("Sections").getDocuments { (Snapshot, error) in
            if error != nil {print("Error") ; return}
            guard let documents = Snapshot?.documents else { return }
            for P in documents {
                if let data =  P.data() as [String : AnyObject]? {
                    let New = SectionObject(Dictionary: data)
                    completion(New)
        }
           
    }
    
}
        
}
}
