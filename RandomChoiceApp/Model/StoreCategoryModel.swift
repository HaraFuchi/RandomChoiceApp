//
//  StoreCategoryModel.swift
//  RandomChoiceApp
//
//  Created by Kazuma Fuchi on 2020/12/17.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation

enum CategoryListType: Int, CaseIterable {
    case store
    case place
    case genre
    case signup
    
    var title: String? {
        switch self {
        case .store: return StoreDataLiteral.store
        case .place: return StoreDataLiteral.place
        case .genre: return StoreDataLiteral.genre
        case .signup: return nil
        }
    }
    
    var placeHolder: String? {
        switch self {
        case .store: return CategoryPlaceHolder.store
        case .place: return CategoryPlaceHolder.place
        case .genre: return CategoryPlaceHolder.genre
        case .signup: return nil
        }
    }
}
