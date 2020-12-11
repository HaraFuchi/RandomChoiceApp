//
//  UIViewController+Alert.swift
//  RandomChoiceApp
//
//  Created by Kazuma Fuchi on 2020/11/25.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import UIKit
import Reachability

protocol AlertDisplayable { }

extension AlertDisplayable where Self: UIViewController {
    func showAlertAllNilTextField() {
        let alert = UIAlertController(title: AlertTitleLiteral.allTextEmpty, message: AlertMessageLiteral
                                        .allTextEmpty, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: AlertButtonLiteral.OK, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //オフライン時にのみ呼ばれるアラート
    func showAlertOffline() {
        let alert = UIAlertController(title: "エラー", message: "インターネット接続状況を確認してください。", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
