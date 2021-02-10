//
//  FirebaseCrudModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

protocol InvalidAlertDisplayable {
    func showAlertNoStoreData() -> Void
}

protocol StoreDataCrudModelDelegate {
    func reload() -> Void
}

class StoreDataCrudModel {
    
    var invalidAlertDelegate: InvalidAlertDisplayable?
    var storeDataCrudModelDelegate: StoreDataCrudModelDelegate?

    private(set) static var storeDataArray = [StoreData]()
    
    private let ref = Database.database().reference()
    
    func createStoreData(store: String, place: String, genre: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let createDataDict = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(userID).childByAutoId().setValue(createDataDict)
    }
    
    func fetchStoreData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.child(userID).observe(.value) { (snapShot) in
            StoreDataCrudModel.storeDataArray.removeAll()
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let postData = snap.value as? [String: String] {
                        let childID = snap.key
                        let storeName = postData[StoreDataType.store]
                        let placeName = postData[StoreDataType.place]
                        let genreName = postData[StoreDataType.genre]
                        let storeDataContent = StoreData(childID: childID,
                                                         store: storeName ?? Mark.questions,
                                                         place: placeName ?? Mark.questions,
                                                         genre: genreName ?? Mark.questions)
                        StoreDataCrudModel.storeDataArray.append(storeDataContent)
                    }
                }
                self.showAlertIfNoStoreData()
                StoreDataCrudModel.storeDataArray.reverse()
                self.storeDataCrudModelDelegate?.reload()
            }
        }
    }
    
    func editStoreData(uniqID: String, store: String, place: String, genre: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let editData = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(userID).child(uniqID).updateChildValues(editData)
    }
    
    func deleteStoreData(indexPath: IndexPath) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let childKey = StoreDataCrudModel.storeDataArray[indexPath.row].childID
        ref.child(userID).child(childKey).removeValue()
    }
}

// MARK: - Method
extension StoreDataCrudModel {
    private func showAlertIfNoStoreData() {
        if StoreDataCrudModel.storeDataArray.isEmpty {
            self.invalidAlertDelegate?.showAlertNoStoreData()
        }
    }
}
