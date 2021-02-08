//
//  ResultStoreDataModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/01/02.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

struct ResultStoreDate {
    static var store = Mark.questions
    static var place = Mark.questions
    static var genre = Mark.questions
}

class ResultStoreDataModel {
    static var questions: String { return Mark.questions }

    static func showResultStoreData() {

        guard let element = StoreDataCrudModel.storeDataArray.randomElement() else { return }

        ResultStoreDate.store = element.storeName ?? questions
        ResultStoreDate.place = element.placeName ?? questions
        ResultStoreDate.genre = element.genreName ?? questions
    }
}
