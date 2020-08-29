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
        let createInfoDict = ["店名":store, "場所": place, "ジャンル": genre]
        ref.child(Auth.auth().currentUser!.uid).childByAutoId().setValue(createInfoDict)
    }
    
    func fetchStoreData(tableView: UITableView?) {
        ref.child(Auth.auth().currentUser?.uid ?? "uid").observe(.value) { (snapShot) in
            self.storeDataArray.removeAll()
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let postData = snap.value as? [String: Any] {
                        let childID = snap.key
                        let storeName = postData["店名"]
                        let placeName = postData["場所"]
                        let genreName = postData["ジャンル"]
                        let storeDataContent = StoreDataContentsModel(childID: childID , store: storeName as! String, place: placeName as! String, genre: genreName as! String )
                        self.storeDataArray.append(storeDataContent)
                    }
                }
                if self.storeDataArray.isEmpty == true {
                    self.delegate?.showNoStoreDataAlert()
                }
                self.storeDataArray.reverse()
                tableView?.reloadData()
            }
        }
    }
    
    func deleteStoreInfo(indexPath: IndexPath) {
        let childKey = storeDataArray[indexPath.row].childID
        ref.child(Auth.auth().currentUser!.uid).child(childKey!).removeValue()
    }
}
