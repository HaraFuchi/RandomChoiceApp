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
    func showAlertNoStoreData()
}

class StoreDataCrudModel {
    
    var delegate: StoreDataCrudModelDelegate?
    var storeDataArray = [StoreDataContentsModel]()
    
    let ref = Database.database().reference()
    
    func createStoreData(store: String, place: String, genre: String) {
        let createDataDict = [StoreDataLiteral.store: store, StoreDataLiteral.place: place, StoreDataLiteral.genre: genre]
        ref.child(Auth.auth().currentUser!.uid).childByAutoId().setValue(createDataDict)
    }
    
    func fetchStoreData(tableView: UITableView?) {
        ref.child(Auth.auth().currentUser?.uid ?? "uid").observe(.value) { (snapShot) in
            self.storeDataArray.removeAll()
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let postData = snap.value as? [String: Any] {
                        let childID = snap.key
                        let storeName = postData[StoreDataLiteral.store]
                        let placeName = postData[StoreDataLiteral.place]
                        let genreName = postData[StoreDataLiteral.genre]
                        let storeDataContent = StoreDataContentsModel(childID: childID , store: storeName as! String, place: placeName as! String, genre: genreName as! String )
                        self.storeDataArray.append(storeDataContent)
                    }
                }
                self.showAlertIfNoStoreData()
                self.storeDataArray.reverse()
                tableView?.reloadData()
            }
        }
    }
    
    func editStoreData(store: String, place: String, genre: String, childID: String?) {
        let newEditData = [StoreDataLiteral.store: store, StoreDataLiteral.place: place, StoreDataLiteral.genre: genre]
        guard let childKey = childID else { return }
        ref.child(Auth.auth().currentUser!.uid).child(childKey).updateChildValues(newEditData)
    }
    
    func deleteStoreData(indexPath: IndexPath) {
        let childKey = storeDataArray[indexPath.row].childID
        ref.child(Auth.auth().currentUser!.uid).child(childKey!).removeValue()
    }
}

// MARK: - Method
extension StoreDataCrudModel {
    private func showAlertIfNoStoreData() {
        if self.storeDataArray.isEmpty {
            self.delegate?.showAlertNoStoreData()
        }
    }
}
