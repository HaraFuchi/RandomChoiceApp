//
//  NSObjec+.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2021/09/18.
//  Copyright © 2021 AYANO HARA. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        String(describing: self)
    }

    var className: String {
        type(of: self).className
    }
}
