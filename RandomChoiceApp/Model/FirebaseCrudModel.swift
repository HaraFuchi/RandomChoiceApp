//
//  FirebaseCrudModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCrudModel {
    
    var listCellArray = [StoreDataModel]()
    
    let uid = Auth.auth().currentUser!.uid
    let ref = Database.database().reference()
    
    func createStoreInfo(store: String, place: String, genre: String) {
        let createInfoDict = ["店名":store, "場所": place, "ジャンル": genre]
        ref.child(uid).childByAutoId().setValue(createInfoDict)
    }
    
//    func fetchStoreData() {
//        ref.child(uid).observe(.value) { (snapShot) in
//            self.listCellArray.removeAll()
//            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
//                for snap in snapShot {
//                    if let postData = snap.value as? [String: Any] {
//                        let storeName = postData["店名"]
//                        let placeName = postData["場所"]
//                        let jenreName = postData["ジャンル"]
//                        self.listCellArray.append(StoreDataModel(store: storeName as! String, place: placeName as! String, jenre: jenreName as! String))
//                    }
//                }
//            }
//        }
//    }
}
