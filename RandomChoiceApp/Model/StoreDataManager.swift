//
//  StoreDataManager.swift
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

protocol StoreDataManagerDelegate {
    func reload() -> Void
}

class StoreDataManager {
    
    var invalidAlertDelegate: InvalidAlertDisplayable?
    var storeDataManagerDelegate: StoreDataManagerDelegate?

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
            StoreDataManager.storeDataArray.removeAll()
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
                        StoreDataManager.storeDataArray.append(storeDataContent)
                    }
                }
                self.showAlertIfNoStoreData()
                StoreDataManager.storeDataArray.reverse()
                self.storeDataManagerDelegate?.reload()
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
        let childKey = StoreDataManager.storeDataArray[indexPath.row].childID
        ref.child(userID).child(childKey).removeValue()
    }
}

// MARK: - Method
extension StoreDataManager {
    private func showAlertIfNoStoreData() {
        if StoreDataManager.storeDataArray.isEmpty {
            self.invalidAlertDelegate?.showAlertNoStoreData()
        }
    }
}
