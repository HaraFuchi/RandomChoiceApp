//
//  FirebaseCrudModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

protocol StoreDataCrudModelDelegate {
    func showNoStoreDataAlert()
}

class StoreDataCrudModel {
    
    var delegate: StoreDataCrudModelDelegate?
    var storeDataArray = [StoreDataContentsModel]()
    
    let ref = Database.database().reference()
    
    func createStoreInfo(store: String, place: String, genre: String) {
        let key = ref.child(Auth.auth().currentUser!.uid).childByAutoId().key
        let createInfoDict = ["店名":store, "場所": place, "ジャンル": genre, "識別ID": key]
        ref.child(Auth.auth().currentUser!.uid).child(key!).setValue(createInfoDict)
    }
    
    func fetchStoreData(tableView: UITableView?) {
        ref.child(Auth.auth().currentUser!.uid).observe(.value) { (snapShot) in
            self.storeDataArray.removeAll()
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let postData = snap.value as? [String: Any] {
                        let storeName = postData["店名"]
                        let placeName = postData["場所"]
                        let genreName = postData["ジャンル"]
                        let childID = postData["識別ID"]
                        let storeDataContent = StoreDataContentsModel(store: storeName as! String, place: placeName as! String, genre: genreName as! String, childID: childID as! String )
                        self.storeDataArray.append(storeDataContent)
                    }
                }
                self.storeDataArray.reverse()
                if self.storeDataArray.isEmpty == true {
                    self.delegate?.showNoStoreDataAlert()
                }
                tableView?.reloadData()
            }
        }
    }
    
    func deleteStoreInfo(indexpath: IndexPath) {
        let childKey = storeDataArray[indexpath.row].childID
        ref.child(Auth.auth().currentUser!.uid).child(childKey!).removeValue()
    }
}
