//
//  StoreCategoryModel.swift
//  RandomChoiceApp
//
//  Created by Kazuma Fuchi on 2020/12/17.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

enum CategoryList: Int, CaseIterable {
    case store
    case place
    case genre
    case signup
    
    var categoryTitle: String? {
        switch self {
        case .store: return "店名"
        case .place: return "場所"
        case .genre: return "ジャンル"
        case .signup: return nil
        }
    }
    
    var categoryPlaceHolder: String? {
        switch self {
        case .store: return "例)サイゼリヤ"
        case .place: return "例)新宿"
        case .genre: return "例)イタリアン"
        case .signup: return nil
        }
    }
}
