//
//  Optional+.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/10/04.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        self == nil || self == ""
    }
}
