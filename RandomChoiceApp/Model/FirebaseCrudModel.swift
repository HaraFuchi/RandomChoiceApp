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
    
    let ref = Database.database().reference()
    
    func createStoreInfo(store: String, place: String, genre: String) {
        let createInfoDict = ["店名":store, "場所": place, "ジャンル": genre]
        ref.child(Auth.auth().currentUser!.uid).childByAutoId().setValue(createInfoDict)
    }
}
