//
//  ResultStoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

class ResultStoreDataModel {
    var store = QuestionsLiteral.questions
    var place = QuestionsLiteral.questions
    var genre = QuestionsLiteral.questions
    
    private var emptyNameText: String { return "???" }
    
    func showResultStoreData() {
        
        guard let element = StoreDataCrudModel.storeDataArray.randomElement() else { return }
                
        store = element.storeName ?? emptyNameText
        place = element.placeName ?? emptyNameText
        genre = element.genreName ?? emptyNameText
    }
}
