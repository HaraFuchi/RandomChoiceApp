//
//  ExtractResultLogic.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

struct ResultData {
    static var store: StoreData?
}

struct ExtractResultLogic {
    static func randomSelectedStoreData() {
        ResultData.store = StoreDataCRUD.storeDataArray.randomElement()
    }
}
