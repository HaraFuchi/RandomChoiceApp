//
//  Converter.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/02/20.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self == nil || self == ""
    }
}
