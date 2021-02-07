//
//  ResultStoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

struct ResultData {
    static var store: StoreData?
}

class ResultStoreDataModel {    
    static func showResultStoreData() {
        
        guard let element = StoreDataCrudModel.storeDataArray.randomElement() else { return }
                
        ResultData.store = element
    }
}
