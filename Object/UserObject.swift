//
//  UserObject.swift
//  Store Project
//
//  Created by Arwa on 10/23/20.
//

import Foundation
import Firebase

class UserObject {

    var ID : String?
    var Stamp : TimeInterval?
    
    var Name : String?
    var Age : Int?
    
    var PhoneNumber: String?
    var Address : String?
    
    var IsMale : Bool?
    
    init(ID: String, Stamp: TimeInterval, Name: String, Age: Int, IsMale: Bool) {
        self.ID = ID
        self.Stamp = Stamp
        self.Name = Name
        self.Age = Age
        self.IsMale = IsMale
    }
    init(Dictionary : [String : AnyObject]) {
        self.ID = Dictionary["ID"] as? String
        self.Stamp = Dictionary["Stamp"] as? TimeInterval
        self.Name = Dictionary["Name"] as? String
        self.Age = Dictionary["Age"] as? Int
        self.IsMale = Dictionary["IsMale"] as? Bool
        self.PhoneNumber = Dictionary["PhoneNumber"] as? String
        self.Address = Dictionary["Address"] as? String
    }
    
    func MakeDictionary() -> [String: AnyObject] {
        var New: [String: AnyObject] = [:]
        New["ID"] = self.ID as AnyObject
        New["Stamp"] = self.Stamp as AnyObject
        New["Name"] = self.Name as AnyObject
        New["Age"] = self.Age as AnyObject
        New["IsMale"] = self.IsMale as AnyObject
        New["PhoneNumber"] = self.PhoneNumber as AnyObject
        New["Address"] = self.Address as AnyObject
        return New
    }
    func Upload(){
    guard let id = self.ID else {return}
        Firestore.firestore().collection("Users").document(id).setData(MakeDictionary())

        }
//    func Remove(){
//    guard let id = self.ID else {return}
//        Firestore.firestore().collection("Users").document(id).delete()
//
//        }
}

class UserApi {
    static func GetUser(ID: String, completion : @escaping (_ user : UserObject)->()){
        Firestore.firestore().collection("Users").document(ID).addSnapshotListener { (Snapshot: DocumentSnapshot?, Error : Error?) in
            
            if let data =  Snapshot?.data() as [String : AnyObject]? {
                let New = UserObject(Dictionary: data)
                completion(New)
            }
        }
    }
}

