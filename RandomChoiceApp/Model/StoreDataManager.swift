//
//  StoreDataManager.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Firebase

protocol InvalidAlertDisplayable: AnyObject {
    func showAlertNoStoreData()
}

protocol StoreDataManagerDelegate: AnyObject {
    func reload()
}

struct StoreDataManager {
    static weak var invalidAlertDelegate: InvalidAlertDisplayable?
    static weak var storeDataManagerDelegate: StoreDataManagerDelegate?

    private(set) static var storeDataList = [StoreData]()

    static private let ref = Database.database().reference()

    static func create(store: String, place: String, genre: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let createDataDict = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(userID).childByAutoId().setValue(createDataDict)
    }

    static func fetchAll() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.child(userID).observe(.value) { (snapShot) in
            StoreDataManager.storeDataList.removeAll()

            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                fetchingStoreDatas(snapShot: snapShot)
            }

            showAlertIfNoStoreData()
            StoreDataManager.storeDataList.reverse()
            storeDataManagerDelegate?.reload()
        }
    }

    // TODO: 引数をStoreDataクラスにした方がオブジェクト指向っぽいかつシンプル
    static func update(uniqID: String, store: String, place: String, genre: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let newEditData = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(userID).child(uniqID).updateChildValues(newEditData)
    }

    // TODO: 引数をStoreDataクラスにした方がオブジェクト指向っぽいかつシンプル
    static func delete(indexPath: IndexPath) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let childKey = StoreDataManager.storeDataList[indexPath.row].childID
        ref.child(userID).child(childKey).removeValue()
    }

    /**********************************************************************/
    // MARK: - Private Method
    /**********************************************************************/
    static private func fetchingStoreDatas(snapShot: [DataSnapshot]) {
        for snap in snapShot {
            if let postData = snap.value as? [String: String] {
                let childID = snap.key
                let store = postData[StoreDataType.store]
                let place = postData[StoreDataType.place]
                let genre = postData[StoreDataType.genre]
                let storeDataContent = StoreData(childID: childID,
                                                 store: store ?? Mark.questions,
                                                 place: place ?? Mark.questions,
                                                 genre: genre ?? Mark.questions)
                StoreDataManager.storeDataList.append(storeDataContent)
            }
        }
    }

    static private func showAlertIfNoStoreData() {
        if StoreDataManager.storeDataList.isEmpty {
            StoreDataManager.invalidAlertDelegate?.showAlertNoStoreData()
        }
    }
}
