//
//  StoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/10.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

struct StoreDataContentsModel {
    static var storeDataArray = [StoreDataContentsModel]()

    let childID: String
    let store: String
    let place: String
    let genre: String
}
