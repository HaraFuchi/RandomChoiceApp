//
//  StoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit

class StoreDataModel {
    var store: String?
    var place: String?
    var jenre: String?
    
    init(store: String, place: String, jenre: String) {
        self.store = store
        self.place = place
        self.jenre = jenre
    }
    
}
