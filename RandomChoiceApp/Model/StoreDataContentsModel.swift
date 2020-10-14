//
//  StoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

class StoreDataContentsModel {
    
    internal var childID: String?
    internal var storeName: String?
    internal var placeName: String?
    internal var genreName: String?
    
    internal init(childID: String, store: String, place: String, genre: String) {
        self.childID = childID
        self.storeName = store
        self.placeName = place
        self.genreName = genre
    }
}
