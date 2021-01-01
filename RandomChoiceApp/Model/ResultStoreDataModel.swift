//
//  ResultStoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

class ResultStoreDataModel {
    var resultStoreName = QuestionsLiteral.questions
    var resultPlaceName = QuestionsLiteral.questions
    var resultGenreName = QuestionsLiteral.questions
    
    private var emptyNameText: String { return "???" }

    func showResultStoreData() {
        let storeDataArray = StoreDataCrudModel.storeDataArray
        
        guard let element = storeDataArray.randomElement() else { return }
        
        resultStoreName = element.storeName ?? emptyNameText
        resultPlaceName = element.placeName ?? emptyNameText
        resultGenreName = element.genreName ?? emptyNameText
    }
}
