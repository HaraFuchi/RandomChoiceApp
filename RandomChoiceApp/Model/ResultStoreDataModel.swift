//
//  ResultStoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

//struct ResultStoreDate {
//    static var store = Mark.questions
//    static var place = Mark.questions
//    static var genre = Mark.questions
//}

class ResultStoreDataModel {
    static func showResultStoreData() {
        guard let element = StoreDataContentsModel.storeDataArray.randomElement() else { return }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(element), forKey: "storeData")
        UserDefaults.standard.synchronize()
        
        
        if let data = UserDefaults.standard.value (forKey:"storeData") as? Data {
            let savedStoreData = try? PropertyListDecoder().decode(StoreDataContentsModel.self, from: data)
            print(savedStoreData)
        } else {
            print("失敗")
        }
    }
}
