//
//  StoreDataManager.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

protocol InvalidAlertDisplayable: AnyObject {
    func showAlertNoStoreData()
}

protocol StoreDataManagerDelegate: AnyObject {
    func reload()
}

class StoreDataManager {

    weak var invalidAlertDelegate: InvalidAlertDisplayable?
    weak var storeDataManagerDelegate: StoreDataManagerDelegate?

    private(set) static var storeDataArray = [StoreData]()

    private let ref = Database.database().reference()

    func createStoreData(store: String, place: String, genre: String) {
        let createDataDict = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(Auth.auth().currentUser!.uid).childByAutoId().setValue(createDataDict)
    }

    func fetchStoreData() {
        ref.child(Auth.auth().currentUser?.uid ?? "uid").observe(.value) { (snapShot) in
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
        let newEditData = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(Auth.auth().currentUser!.uid).child(uniqID).updateChildValues(newEditData)
    }

    func deleteStoreData(indexPath: IndexPath) {
        let childKey = StoreDataManager.storeDataArray[indexPath.row].childID
        ref.child(Auth.auth().currentUser!.uid).child(childKey).removeValue()
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
