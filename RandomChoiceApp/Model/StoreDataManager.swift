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

struct StoreDataManager {
    static weak var invalidAlertDelegate: InvalidAlertDisplayable?

    private(set) static var storeDataList = [StoreData]()

    static private let ref = Database.database().reference()

    static func create(store: String, place: String, genre: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let createDataDict = [StoreDataType.store: store, StoreDataType.place: place, StoreDataType.genre: genre]
        ref.child(userID).childByAutoId().setValue(createDataDict)
    }

    static func fetchAll(completionHandler: (() -> Void)? = nil) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.child(userID).observe(.value) { (snapShot) in
            StoreDataManager.storeDataList.removeAll()

            guard let snapShot = snapShot.children.allObjects as? [DataSnapshot] else { return }

            StoreDataManager.storeDataList.append(contentsOf: fetchingStoreDatas(snapShot: snapShot))

            showAlertIfNoStoreData()
            StoreDataManager.storeDataList.reverse()
            completionHandler?()
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
        guard let childKey = StoreDataManager.storeDataList[indexPath.row].childID else { return }
        ref.child(userID).child(childKey).removeValue()
    }

    /**********************************************************************/
    // MARK: - Private Method
    /**********************************************************************/
    static private func fetchingStoreDatas(snapShot: [DataSnapshot]) -> [StoreData] {
        return snapShot.map {
            guard let postData = $0.value as? [String: String] else { return nil }
            return StoreData(childID: $0.key,
                             store: postData[StoreDataType.store],
                             place: postData[StoreDataType.place],
                             genre: postData[StoreDataType.genre])
        }.compactMap { $0 }
    }

    static private func showAlertIfNoStoreData() {
        if StoreDataManager.storeDataList.isEmpty {
            StoreDataManager.invalidAlertDelegate?.showAlertNoStoreData()
        }
    }
}
