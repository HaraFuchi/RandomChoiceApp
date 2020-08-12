//
//  StoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

class StoreDataContentsModel {
    
    var storeName: String?
    var placeName: String?
    var genreName: String?
    
    init(store: String, place: String, genre: String) {
        self.storeName = store
        self.placeName = place
        self.genreName = genre
    }
}
