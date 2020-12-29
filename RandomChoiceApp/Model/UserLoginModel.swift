//
//  UserLoginModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/17.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

class UserLoginModel {
    static func anonymous() {
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error {
                print("Auth Error :\(error.localizedDescription)")
            }
            guard let user = authResult?.user else { return }
            _ = user.isAnonymous  // true
            _ = user.uid
            return
        }
    }
}
