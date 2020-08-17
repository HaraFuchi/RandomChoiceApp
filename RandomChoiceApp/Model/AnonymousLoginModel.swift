//
//  AnonymousLoginModel.swift
//  RandomChoiceApp
//
//  Created by 渕一真 on 2020/08/17.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Firebase

//匿名ログイン認証
class AnonymousLoginModel {
    
    func anonymousLogin() {
        // 匿名認証(下記のメソッドがエラーなく終了すれば、認証完了する)
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let error = error {
                print("Auth Error :\(error.localizedDescription)")
            }
            // 認証情報の取得
            guard let user = authResult?.user else { return }
            _ = user.isAnonymous  // true
            _ = user.uid
            return
        }
    }
}
