//
//  NetworkStatusModel.swift
//  RandomChoiceApp
//
//  Created by AYANO HARA on 2020/12/11.
//  Copyright © 2020 AYANO HARA. All rights reserved.
//

import Foundation
import Reachability

class NetworkStatusModel {
    let reachability = try! Reachability()
    
    func checkNetworkStatus() {
        if reachability.connection == .unavailable {
            // インターネット接続なし
        } else {
            // インターネット接続あり
        }
    }
}
